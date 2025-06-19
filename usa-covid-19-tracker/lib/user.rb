require 'bcrypt'
require 'json'

class User
  attr_accessor :username, :password

  @@users = []

  def initialize(username, password)
    @username = username
    @password = BCrypt::Password.create(password)
      # add the user to an external file
    User.store_credentials(self)
    @@users << self
  end

  def self.all
    @@users
  end

  # authenticate user to login
  def self.authenticate(username, password)
    user = User.find_by_username(username)

    if user && user.password == password
      return user
    else
      return nil
    end
  end

  def self.find_by_username(username)
    user = all.find do |user|
      user.username == username
    end
  end

  def self.store_credentials(user)
    # Step 1: Create a file if it doesn't exist
    file_path = "users.json"
    unless File.exist?(file_path)
      File.open(file_path, "w") { |file| file.write(JSON.generate([])) }
    end

    # Step 2: Add user to the file
    file = File.read(file_path)
    users_data = JSON.parse(file)

    users_data << { username: user.username, password: user.password }

    File.open(file_path, "w") { |file| file.write(JSON.generate(users_data)) }

  end
end