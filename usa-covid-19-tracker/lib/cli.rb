require_relative 'scraper.rb'
require_relative 'country.rb'
require_relative 'state.rb'
require_relative 'user.rb'

class CLI
  # run
    def run
      User.load_users_from_file
      authenticate 
      Scraper.scrape_data
      greeting
      while menu != 'exit'
      end
      end_program
    end

  # greeting
    def greeting
      puts "Welcome to the USA Covid 19 tracker!"
    end

  # end program
    def end_program
      puts "Thank you for using the USA Covid 19 tracker!"
    end

  # menu
    def menu
      list_options
      input = gets.chomp.downcase
      choose_option(input)
      input
    end

  # list of options
    def list_options
      puts "Please select an option:"
      puts "1. List all states!"
      puts "2. List top 10 states with the most confirmed Covid cases!"
      puts "3. Print USA information!"
      puts "4. List top 10 states with the most overall Covid deaths!"
      puts "Exit the program by entering 'exit'!"
    end

    def choose_option(option)
      case option
      when "1"
        puts "Listing all states..."
        State.all.each do |state|
          puts "---------"
          puts "Name: #{state.name}"
          puts "Cases: #{state.confirmed_cases}"
          puts "Deaths: #{state.overall_deaths}"
          puts "Recoveries: #{state.recoveries}"
          puts "---------"
        end
      when "2"
        puts "Listing top 10 states with the most confirmed Covid cases..."
        State.all[0..9].each_with_index do |state, i|
          puts "#{i+1}. #{state.name} - #{state.confirmed_cases}"
        end
      when "3"
        puts "Printing USA information..."
        country = Country.first
        puts country.name
        puts country.confirmed_cases
        puts country.overall_deaths
        puts country.recoveries
      
      when "4"
        puts "Listing top 10 states with the most overall Covid deaths..."

        sort_states = State.all.sort_by {|state| state.overall_deaths.gsub(/,/, '').to_i}

        sort_states[0..9].each_with_index do |state, i|
          puts "#{i+1}. #{state.name} - #{state.overall_deaths}"
        end
    end
end

  def authenticate
    authenticated = false

    until authenticated
      puts "Please login or sign up!!"
      puts "Which do you choose? Sign up? Or login?"
        get_input = gets.chomp
        if get_input == "login"
          # authenticate user
          authenticated = login
        elsif get_input === 'sign up'
          # create account process
          create_account
        else 
          puts "Please enter a valid option. "
        end
    end
  end

  def login
    puts "Please enter your username!"
    username = gets.chomp
    puts "Please enter your password!"
    password = gets.chomp

    # call authenticate from user class

    result = User.authenticate(username, password)

    if result
      puts "Welcome back #{username}!"
    else
      puts "Invalid username or password!"
    end

    result
  end

  def create_account
    # get user info
    puts "Please enter your username!"
    username = gets.chomp
    puts "Please enter your password!"
    password = gets.chomp

    user = User.new(username, password)

      # add the user to an external file
      User.store_credentials(user)

    puts "Account created!!"
  end
end