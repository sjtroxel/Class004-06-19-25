require "bcrypt"

my_password = BCrypt::Password.create("my password")

puts my_password