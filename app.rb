require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/database_connection'
require_relative './lib/space_repository'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    DatabaseConnection.connect('makersbnb_test')
  end

  get '/home' do
    return erb(:home)
=======
  get '/' do
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

end