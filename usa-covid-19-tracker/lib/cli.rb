require_relative 'scraper.rb'
require_relative 'country.rb'

class CLI
  # run
    def run
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
      puts "Exit the program by entering 'exit'!"
    end

    def choose_option(option)
      case option
      when "1"
        puts "Listing all states..."
      when "2"
        puts "Listing top 10 states with the most confirmed Covid cases..."
      when "3"
        puts "Printing USA information..."
        country = Country.first
        puts country.name
        puts country.confirmed_cases
        puts country.overall_deaths
        puts country.recoveries
      end
    end
end