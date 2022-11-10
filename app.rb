require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/database_connection'
require_relative './lib/space_repository'
require_relative './lib/user_repository'
require_relative './lib/space'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    DatabaseConnection.connect('makersbnb_test')
  end

  enable :sessions

  get '/' do
    return erb(:index)
  end

  get '/create_user' do
    return erb(:create_user)
  end

  get '/login' do
    return erb(:login)
  end

  get '/spaces' do
    repo = SpaceRepository.new
    @spaces = repo.all
    return erb(:spaces)
  end

  post '/create_user' do
    repo = UserRepository.new
    @user = User.new
    @user.username = params[:username]
    @user.email = params[:email]
    @user.password = params[:password]

    repo.create(@user)
    
    return erb(:redirect)
  end

  post '/login' do
    repo = UserRepository.new
    username = params[:username]
    password = params[:password]
    user = repo.find_by_username(username)
    if user.password == password
      return erb(:redirect)
    else
      return erb(:failure)
    end
  end

  get '/spaces/:id' do
    space_id = params[:id]
    spaces_repo = SpaceRepository.new
    @space = spaces_repo.find(space_id)
    return erb(:space)
  end

  get '/space_form' do
    return erb(:space_form)
  end

  post '/add_space' do
    new_space = Space.new
    new_space.space_name = params[:space_name]
    new_space.description = params[:space_description]
    new_space.price = params[:space_price]
    new_space.user_id = 1
    spaces_repo = SpaceRepository.new
    spaces_repo.create(new_space)
    return erb(:space_added)
  end
end