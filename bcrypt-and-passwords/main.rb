# require "bcrypt"

# my_password = BCrypt::Password.create("my password")

# puts my_password == "my password" # true

# puts my_password == "not my password" # false

require "bcrypt"

class User
  attr_accessor :username, :password

  @@users = []
  def initialize(username, password)
    @username = username
    @password = BCrypt::Password.create(password)
    @@users << self
  end

  def self.authenticate(username, password)
    user = User.find_by_username(username)

    if user && user.password == password
      return user
    else
      return nil
    end
  end

  def self.all
    @@users
  end

  def self.find_by_username(username)
    user = all.find do |user|
      user.username == username
    end
    user
  end
end

User.new("username", "password")
user = User.find_by_username("username") # returns user object
puts User.authenticate("username", "password") # returns user object
puts User.authenticate("username", "not password") # returns nil

puts User.authenticate("username", "password").inspect