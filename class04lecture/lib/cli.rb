require_relative 'api'

class CLI
  def run
    User.seed
    system('clear')
    greet
    sign_in
    while menu!= 'exit'
      end
    goodbye
  end

  def sign_in
    is_authenticated = false

    until is_authenticated
      puts "Please enter your username: "

      username = gets.chomp

      puts "Please enter your password: "

      password = gets.chomp

      is_authenticated = Auth.authenticate_user(username, password, User.all)

      if is_authenticated
        @current_user = is_authenticated
        puts "Welcome #{username}!"
      else
        puts "Invalid credentials! Please try again!"
      end
    end
  end

  def enter_credentials
    puts "Do you have an account? Type 'Y' to sign in, or 'N' to sign up!"

    has_account = gets.chomp.downcase == 'y'

    if has_account
      sign_in
    else
        sign_up
    

    end
  end

  def sign_up
    puts "Sign Up\n\n"

    puts "Please enter a username!"

    username = gets.chomp

    puts "Please enter a password!"

    password = gets.chomp

    if username == '' || password == ''
      puts "Invalid credentials! Please try again!"

      sign_up
      return nil
    end

    User.new(username, password)

    puts "Welcome, #{username}! Please sign in to continue."

    sign_in
  end

  def greet
    puts 'Welcome to the Oscar Winning Films CLI!'
  end

  def goodbye
    puts "Goodbye! #{@current_user.username}! :("
  end

  def menu
    puts "\n Please enter a year to see the Oscar Winning Films for that year: \n\n"

    input_year = gets.chomp

    find_films_by_year(input_year) unless input_year == 'exit'

    input_year
  end

  def find_films_by_year(year)
    puts "\n Let me find the Oscar Winning Films for #{year}... \n\n"
    API.find_films_by_year(year)
   
  end
end