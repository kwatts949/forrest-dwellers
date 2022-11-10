require 'user_repository'

describe UserRepository do
def reset_spaces_table
  seed_sql = File.read('seeds/users_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

  before(:each) do 
    reset_spaces_table
  end

  context 'all method' do
    it 'returns a list of all the users' do
      repo = UserRepository.new

      users = repo.all 
      expect(users.length).to eq 4
      expect(users.first.id).to eq '1'
      expect(users.first.username).to eq "George"
      expect(users.last.email).to eq "henry@makers.com"
    end
  end
  
  context 'create method' do
    it 'creates a new user' do
    repo = UserRepository.new

    new_user = User.new
    new_user.username = 'Sarah'
    new_user.email = 'sarah@makers.com'
    new_user.password = 'asdf'
    
    repo.create(new_user)

    all_users = repo.all

    expect(all_users).to include (
      have_attributes(
        username: new_user.username,
        email: new_user.email,
        password: new_user.password,
      ))
    end
  end

  context 'find by email method' do
    it 'finds a user by their email address' do
      repo = UserRepository.new

      result = repo.find_by_email('george@makers.com')

      expect(result.password).to eq ('password')
      expect(result.email).to eq ('george@makers.com')
    end
  end

  context 'login method' do
    it 'logs in the user' do 
      repo = UserRepository.new

      result1 = repo.login('George', 'password')
      result2 = repo.login('George', 'asdf')
      expect(result1).to eq true
      expect(result2).to eq false
    end
  end

  context 'find by username method' do
    it 'finds a user by their username' do
      repo = UserRepository.new

      result = repo.find_by_username('George')

      expect(result.password).to eq ('password')
      expect(result.email).to eq ('george@makers.com')
    end
  end
end