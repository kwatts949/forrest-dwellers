require_relative './space'

class SpaceRepository
  def all
    sql = 'SELECT id, space_name, description, price FROM spaces;'
    result_set = DatabaseConnection.exec_params(sql, [])

    spaces = []

    result_set.each do |record|
      space = Space.new
      space.id = record['id']
      space.space_name = record['space_name']
      space.description = record['description']
      space.price = record['price']

      spaces << space
    end
    return spaces
  end

  def create(space)
    sql = 'INSERT INTO spaces (space_name, description, price, user_id, start_date, end_date) VALUES ($1, $2, $3, $4, $5, $6);'
    sql_params = [space.space_name, space.description, space.price, space.user_id, space.start_date, space.end_date]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def find(id)
    sql = 'SELECT id, space_name, description, price, user_id, start_date, end_date FROM spaces WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])

    space = Space.new
    space.id = result_set[0]['id'].to_i
    space.space_name = result_set[0]['space_name']
    space.description = result_set[0]['description']
    space.price = result_set[0]['price'].to_i
    space.user_id = result_set[0]['user_id'].to_i
    space.start_date = result_set[0]['start_date']
    space.end_date = result_set[0]['end_date']

    return space
  end

  def find_with_date(start_date, end_date)
    sql = 'SELECT id, space_name, description, price,
      user_id, start_date, end_date FROM spaces 
      WHERE start_date <= $1 AND $2 <= end_date;'
    result_set = DatabaseConnection.exec_params(sql, [start_date, end_date])
    spaces = []

    result_set.each do |record|
      space = Space.new
      space.id = record['id']
      space.space_name = record['space_name']
      space.description = record['description']
      space.price = record['price']

      spaces << space
    end
    return spaces
  end

  def all_by_user(user_id)
    sql = 'SELECT id, space_name, description, price, user_id, start_date, end_date FROM spaces WHERE user_id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [user_id])

    spaces = []

    result_set.each do |record|
      space = Space.new
      space.id = record['id'].to_i
      space.space_name = record['space_name']
      space.description = record['description']
      space.user_id = record['user_id']
      space.price = record['price'].to_i
      space.start_date = record['start_date']
      space.end_date = record['end_date']

      spaces << space
    end
    return spaces
  end
end