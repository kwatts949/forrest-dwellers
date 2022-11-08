require_relative './user'
require 'bcrypt'

# store users class
class UserRepository
  # list out users
  # no arguments

  def all
    sql = 'SELECT id, username, email, password FROM users;'
    result_set = DatabaseConnection.exec_params(sql, [])
    
    users = []

    result_set.each do |record|
      user = User.new
      user.id = record['id']
      user.username = record['username']
      user.email = record['email']
      user.password = record['password']

      users << user
    end
    return users
  end


  def find_by_email(email)
    sql = 'SELECT * FROM users WHERE email = $1;'
      result_set = DatabaseConnection.exec_params(sql, [email])
      result_set = result_set[0]

      user = User.new
      user.id = result_set['id'].to_i
      user.username = result_set['username']
      user.email = result_set['email']
      user.password = result_set['password']

    return user
  end

  def login(email, submitted_password)
    user = find_by_email(email)

    return nil if user.nil?

    submitted_password == (user.password)
  end

  def create(user)
    sql = 'INSERT INTO users (username, email, password) VALUES ($1, $2, $3);'
    sql_params = [user.username, user.email, user.password]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end
end
