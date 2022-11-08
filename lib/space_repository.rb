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
    sql = 'INSERT INTO spaces (space_name, description, price, user_id) VALUES ($1, $2, $3, $4);'
    sql_params = [space.space_name, space.description, space.price, space.user_id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end
end