require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  # Write your integration tests below.
  # If you want to split your integration tests
  # accross multiple RSpec files (for example, have
  # one test suite for each set of related features),
  # you can duplicate this test file to create a new one.
  def reset_users_table
    seed_sql = File.read(spec/seeds/user_seeds.sql)
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
  end
  

  context 'GET /home' do
    it 'should get the homepage' do
      response = get('/home')
      expect(response.status).to eq(200)
    end
  end

  context 'GET /spaces' do
    it 'should get spaces list page' do
      response = get('/spaces')
      expect(response.status).to eq(200)
    end

    xit 'page should include first space' do
      response = get('/spaces')
      expect(response.status).to eq(200)
      expect(response.body).to include('<div class="space-title">Igloo</div>')
      expect(response.body).to include('<div class="space-price">40£</div>')
      expect(response.body).to include('<p class="space-describtion">Nice fireplace but cold outside</p>')
    end
  end

  context 'GET /login' do
    it 'should get the login page' do
      response = get('/login')

      expect(response.status).to eq(200)
    end
  end

  context 'POST /home creates a new user' do
    it 'should create a new user in the table' do
      response = post('/home', username: "asdf", email: "asdf@email.com", password: "Makers")
      expect(response.status).to eq(200)
      expect(response.body).to include('<p> You have successfully signed up! </p>')
    end
  end

  context 'POST /login' do
    xit 'should successfully login and redirect to spaces page' do
      response = post('/login', username: 'Kay', password: '1234')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Book a Space</h1>')
    end
  end
end