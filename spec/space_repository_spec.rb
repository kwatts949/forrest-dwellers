require 'space_repository'

describe SpaceRepository do
def reset_spaces_table
  seed_sql = File.read('seeds/spaces_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

  before(:each) do 
    reset_spaces_table
  end

  context 'all method' do
    it 'returns a list of all the spaces' do
      repo = SpaceRepository.new

      spaces = repo.all 

      expect(spaces.length).to eq 2
      expect(spaces.first.id).to eq '1'
      expect(spaces.first.space_name).to eq "Igloo"
      expect(spaces.last.description).to eq "Boring and unremarkable"
    end
  end

  context 'create method' do
    it 'creates a new space' do
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

  context 'find method' do
    it 'finds one space by its id' do
      repo = SpaceRepository.new

      space = repo.find(2)
    
      expect(space.id).to eq(2)
      expect(space.space_name).to eq('Flat')
      expect(space.description).to eq('Boring and unremarkable')
      expect(space.price).to eq(120)
    end
  end
end