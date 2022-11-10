require 'booking_repository'
require 'booking'

describe BookingRepository do
  def reset_spaces_table
    seed_sql = File.read('seeds/bookings_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_spaces_table
  end

  context "find_booked_date" do
    it 'should return booked dates for space 1' do
      repo = BookingRepository.new
      dates = repo.find_booked_dates(1)
      expect(dates).to eq(["2023-04-12", "2023-06-01", "2023-11-03"])
    end

    it 'should return empty array for space 3' do
      repo = BookingRepository.new
      dates = repo.find_booked_dates(3)
      expect(dates).to eq([])
    end

    it 'should return empty array for space 2' do
      repo = BookingRepository.new
      dates = repo.find_booked_dates(2)
      expect(dates).to eq(["2023-07-24", "2023-12-02", "2023-06-14"])
    end
  end

  context "create new booking" do
    it 'should return 4 dates for space 1' do
      booking = Booking.new
      booking.booking_date = '2022-11-11'
      booking.space_id = 1
      booking.user_id = 1

      repo = BookingRepository.new
      repo.create(booking)
      dates = repo.find_booked_dates(1)
      expect(dates).to eq(["2023-04-12", "2023-06-01", "2023-11-03", "2022-11-11"])
    end
  end
end