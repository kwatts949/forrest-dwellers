require_relative './booking'

class BookingRepository
  def find_booked_dates(space_id)
    sql = 'SELECT booking_date FROM bookings WHERE space_id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [space_id])
    dates = []
    result_set.each do |record|
      dates << record['booking_date']
    end
    return dates
  end

  def create(booking)
    sql = 'INSERT INTO bookings (booking_date, space_id, user_id) VALUES ($1, $2, $3);'
    sql_params = [booking.booking_date, booking.space_id, booking.user_id]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end
end
