1. Design and create the Table (SKIP)
If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.




2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO students (name, cohort_name) VALUES ('David', 'April 2022');
INSERT INTO students (name, cohort_name) VALUES ('Anna', 'May 2022');
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql




3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.


# Table name: albums

# Model class
# (in lib/album.rb)

class Album
end

# Repository class
# (in lib/album_repository.rb)
class AlbumRepository
end




4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.



# Table name: albums

# Model class
# (in lib/album.rb)

class Album

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :release_year, :artist_id
end



# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.




5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.


# Table name: albums

# Repository class
# (in lib/album_repository.rb)
class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;

    # Returns an array of Album objects.
  end

  # Finding one record
  # Taking the record id as an argument
  def find(id)
    sql = "SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    # (The code now needs to convert the result to an Album object and return it)
  end

  # Creating a new record
  # Taking the new instance of Album as an argument
  def create(album)
    # sql = "INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3)"

  end
end




6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# 1
# Get all albums - #all

repo = AlbumRepository.new
albums = repo.all

  albums.length => 2
  albums.first.id => 1
  albums.last.id => 11
  albums.last.title => 'Fodder on My Wings'


# 2
# Find an album - #find(id)

# 1
repo = AlbumRepository.new
album = repo.find(3)

  album.id => 3
  album.title => 'Waterloo'
  album.release_year => 1972
  album.artist_id => 2

# 2

repo = AlbumRepository.new
album = repo.find(1)

  expect(album.id).to eq '1'
  expect(album.title).to eq 'Doolittle'
  expect(album.release_year).to eq '1989'
  expect(album.artist_id).to eq '1'


# 3
# Create a new album = #create(album)

repo = AlbumRepository.new

album = Album.new
Album.title = 'Indie Cindy'
Album.release_year = '2014'
Album.artist_id = '1'

repo.create(album)

albums = repo.all
expect(albums.last.id).to eq '12'
expect(albums.last.title).to eq 'Indie Cindy'
expect(albums.last.release_year).to eq '2014'
expect(albums.last.artist_id).to eq '1'






# EXAMPLES

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

# Add more examples for each method
Encode this example as a test.




7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.


# file: spec/album_repository_spec.rb

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do 
    reset_albums_table
  end

  # (your tests will go here).
end




8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.
