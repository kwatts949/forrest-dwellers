require_relative 'user'
require 'bcrypt'

# store users class
class UserRepository
  # list out users
  # no arguments

  def list
    # sql request:
    # SELECT id, author, email FROM users
    sql = 'SELECT id, name, email, password FROM users'
    result_set = DatabaseConnection.exec_params(sql, [])

    users = []

    result_set.each do |record|
      user = create_user(record)
      users << user
    end

    users
    # returns an array of users instances
  end
  
  # add a new user to the repository
  # one argument: User object
  def add(user)
    encrypted_password = BCrypt::Password.create(user.password)
    # sql request:
    # INSERT INTO users (author, email, password) VALUES ($1, $2, $3);
    sql = 'INSERT INTO users (name, email, password) VALUES ($1, $2, $3) RETURNING id;'
    sql_params = [user.name, user.email, encrypted_password]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    user_id = result_set[0]["id"]
    user_id
  end

  def find_by_email(email)
    sql = 'SELECT * FROM users WHERE email = $1'
    result_set = DatabaseConnection.exec_params(sql, [email])
    user = create_user(result_set[0])

    user
  end

  def sign_in(email, submitted_password)
    user = find_by_email(email)

    # return nil if user.nil?
    return user if BCrypt::Password.new(user.password) == submitted_password

    false
  end

  def create_user(record)
    user = User.new
    user.id = record['id']
    user.name = record['name']
    user.email = record['email']
    user.password = record['password']
    user
  end
end