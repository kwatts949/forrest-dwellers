require 'sinatra/base'
require 'sinatra/reloader'
require 'date'
require_relative './lib/database_connection'
require_relative './lib/space_repository'
require_relative './lib/user_repository'
require_relative './lib/space'
require_relative './lib/booking_repository'

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
    @today = Date.today
    @tomorrow = @today.next_day
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
      session[:id] = user.id
      return erb(:redirect)
    else
      return erb(:failure)
    end
  end

  get '/spaces/search' do
    @today = Date.today
    @tomorrow = @today.next_day
    repo = SpaceRepository.new
    start_date, end_date = validate_date(params[:start_date], params[:end_date])
    @spaces = repo.find_with_date(start_date, end_date )
    return erb(:spaces)
  end

  post '/spaces/book' do
    booking_repo = BookingRepository.new
    booking = Booking.new
    booking.space_id = params[:space_id]
    booking.booking_date = params[:booking_date]
    booking.user_id = params[:user_id]
    booking_repo.create(booking)
    return erb(:book_added)
  end
  
  get '/spaces/:id' do
    space_id = params[:id]
    spaces_repo = SpaceRepository.new
    @space = spaces_repo.find(space_id)
    avalible = avalible_days(@space.start_date, @space.end_date)
    booking_repo = BookingRepository.new
    unavalible = booking_repo.find_booked_dates(space_id)
    @days = avalible - unavalible
    return erb(:space)
  end

  get '/space_form' do
    @today = Date.today
    @tomorrow = @today.next_day
    return erb(:space_form)
  end

  post '/add_space' do
    new_space = Space.new
    new_space.space_name = params[:space_name]
    new_space.description = params[:space_description]
    new_space.price = params[:space_price]
    new_space.user_id = session[:id]
    new_space.start_date = params[:start_date]
    new_space.end_date = params[:end_date]
    spaces_repo = SpaceRepository.new
    spaces_repo.create(new_space)
    return erb(:space_added)
  end

  get '/requests/:user_id' do
    spaces_repo = SpaceRepository.new
    @spaces = spaces_repo.all_by_user(params[:user_id])
    return erb(:requests)
  end

  private

  def avalible_days(start_date, end_date)
    days = [start_date]
    while days.last != end_date 
      days << Date.parse(days.last).next_day.strftime("%Y-%m-%d")
    end
    return days
  end

  def validate_date(start_date, end_date)
    date1 = start_date.split('-')
    date2 = end_date.split('-')
    if (date2[0].to_i < date1[0].to_i) ||
      (date2[1].to_i < date1[1].to_i && 
        date2[0].to_i >= date1[0].to_i) ||
      (date2[2].to_i < date1[2].to_i && 
        date2[1].to_i >= date1[1].to_i && 
        date2[0].to_i >= date1[0].to_i)
      date1, date2 = date2, date1
    end
    return date1, date2
  end

end