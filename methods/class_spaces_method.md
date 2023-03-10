# **{{TABLE NAME}} Model and Repository Classes Design Recipe**

## **1. Design and create the Table**

## **2. Create Test SQL seeds**


-- (file: spec/spaces_seeds.sql)

TRUNCATE TABLE spaces RESTART IDENTITY CASCADE;

INSERT INTO spaces (space_name, description, price, booked, user_id) VALUES ('Igloo', 'Nice fireplace but cold outside', 40.00, false, 1);
INSERT INTO spaces (space_name, description, price, booked, user_id) VALUES ('Flat', 'Boring and unremarkable', 120.00, false, 3);


`psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql`

## **3. Define the class names**

# Table name: spaces

# Model class
# (in lib/space.rb)
class Space
end

# Repository class
# (in lib/student_repository.rb)
class SpaceRepository
end

## **4. Implement the Model class**

# Table name: spaces

# Model class
# (in lib/space.rb)

class Space
  attr_accessor :id, :space_name, :description, :price, :booked, :user_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name`

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## **5. Define the Repository Class interface**

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

`# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class StudentRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;

    # Returns a single Student object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(student)
  # end
end`

## **6. Write Test Examples**

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

`# EXAMPLES

# 1
# Get all students

repo = StudentRepository.new

students = repo.all

students.length # =>  2

students[0].id # =>  1
students[0].name # =>  'David'
students[0].cohort_name # =>  'April 2022'

students[1].id # =>  2
students[1].name # =>  'Anna'
students[1].cohort_name # =>  'May 2022'

# 2
# Get a single student

repo = StudentRepository.new

student = repo.find(1)

student.id # =>  1
student.name # =>  'David'
student.cohort_name # =>  'April 2022'

# Add more examples for each method`

Encode this example as a test.

## **7. Reload the SQL seeds before each test run**

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

`# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end`

## **8. Test-drive and implement the Repository class behaviour**

*After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.*