require_relative 'auth'

class User
  @@users = []

  attr_accessor :id, :username, :password

  def initialize(username, password)
    @username = username
    @password = Auth.create_hash_digest(password)
    @id = @@users.length + 1

    @@users << self
  end

  def self.all
    @@users
  end

  def self.seed
    users = [{ username: 'joe', password: 'password' }]

    users.each do |user|
      User.new(user[:username], user[:password])
    end

    def self.find(id)
      self.all.find { |user| user.id == id }
    end
  end
end