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
    it 'returns a list of all the spaces' do
      repo = UserRepository.new

      users = repo.list 

      expect(users.length).to eq 4
      expect(users.first.id).to eq '1'
      expect(users.first.username).to eq "George"
      expect(users.last.email).to eq "henry@makers.com"
    end
  end
=begin
  context 'create method' do
    xit 'creates a new space' do
    repo = SpaceRepository.new

    new_space = Space.new
    new_space.space_name = 'Farm'
    new_space.description = 'A bit smelly with lovely views'
    new_space.price = '150'
    new_space.user_id = 2
    
    repo.create(new_space)

    all_spaces = repo.all

    expect(all_spaces).to include (
      have_attributes(
        space_name: new_space.space_name,
        description: new_space.description,
        price: new_space.price,
      ))
    end
  end
end

=end