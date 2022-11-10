require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/database_connection'
require_relative './lib/space_repository'
require_relative './lib/user_repository'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    DatabaseConnection.connect('makersbnb_test')
  end

  enable :sessions

  get '/' do
    return erb(:index)
  end

  get '/home' do
    return erb(:home)
  end

  get '/spaces' do
    repo = SpaceRepository.new
    @spaces = repo.all
    return erb(:spaces)
  end

  get '/login' do
    return erb(:login)
  end

  post '/home' do
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
      session[:user_id] = user.id
      return erb(:redirect)
    else
      return erb(:failure)
    end
  end
end