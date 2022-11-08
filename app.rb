require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/home' do
    return erb(:home)
  end

  get '/login' do
    return erb(:login)
  end

end