1. Design and create the Table
Otherwise, follow this user_account to design and create the SQL schema for your table.

See 'social_network_tables_user_account.md'




2. Create Test SQL seeds
Your tests will depend on data stored in StudentgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- (file: spec/seeds_cohorts.sql)

-- Write your SQL seed here. 


# 1 cohorts_table
-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE cohorts RESTART IDENTITY;
TRUNCATE TABLE students RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO "cohorts" (name, starting_date) VALUES ('One', 2022-09-01);
INSERT INTO "cohorts" (name, starting_date) VALUES ('Two', 2022-10-01);
INSERT INTO "cohorts" (name, starting_date) VALUES ('Three', 2022-11-01);

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 social_network_test < seeds_cohorts.sql


# 2 students_table

-- (file: spec/seeds_students.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE cohorts RESTART IDENTITY;
TRUNCATE TABLE students RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO "students" (name, cohort_id) VALUES ('Andy', 1);
INSERT INTO "students" (name, cohort_id) VALUES ('James', 1);
INSERT INTO "students" (name, cohort_id) VALUES ('Scott', 2);
INSERT INTO "students" (name, cohort_id) VALUES ('Lewis', 2);
INSERT INTO "students" (name, cohort_id) VALUES ('Andre', 3);
INSERT INTO "students" (name, cohort_id) VALUES ('Jimmy', 3);


Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 social_network_test < seeds_students.sql




3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.


# 1 Table name: cohorts

# Model class
# (in lib/user_account.rb)

class Cohort
end

# Repository class
# (in lib/user_account_repository.rb)
class CohortRepository
end




# 2 Table name: students

# Model class
# (in lib/students.rb)

class Student
end

# Repository class
# (in lib/Student_repository.rb)
class StudentRepository
end






4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.


# 1 Table name: cohorts

# Model class
# (in lib/user_account.rb)

class Cohort
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :starting_date, :students

  def initialize
    @students = []
  end
end


# 2 Table name: students

# Model class
# (in lib/students.rb)

class Student
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :cohort_id
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


# 1 Table name: cohorts

# Repository class
# (in lib/user_account_repository.rb)
class CohortRepository
  <!-- # Selecting all records
  # No arguments
  def all
    # Executes the SQL query below:
    sql = "SELECT id, name, email_address, username FROM cohorts;"
    result_set = DatabaseConnection.exec_params(sql, [])

    cohorts = []

    # loop through results and create an array of user_account objects
    # Return array of user_account objects.
  end -->

  <!-- # Finding one record
  # Taking the record id as an argument
  def find(id)
    sql = "SELECT id, name, email_address, username FROM cohorts WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    # (The code now needs to convert the result to an Album object and return it)
  end -->


  # Find one cohort and list students in this cohort
  # (in lib/cohort_repository.rb)
  def find_with_students(id)
    sql = "SELECT cohorts.id AS cohort_id,
          cohorts.name AS cohort_name,
          cohorts.starting_date,
          students.name AS student_name,
          students.id AS student_id
          FROM cohorts
          JOIN students ON cohorts.id = students.cohort_id
          WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    # create cohort object and add all data (from record)
    # add student info to cohort.@students array (loop through result_set)
    # return cohort object    
  end

  <!-- # Creating a new user_account record (takes an instance of Cohort)
  def create(user_account)
    sql = "INSERT INTO cohorts (name, email_address, username) VALUES($1, $2, $3);"
    params = [user_account.name, user_account.email_address, user_account.username]
    DatabaseConnection.exec_params(sql, params)
  end


  def delete(id)
    sql = "DELETE FROM cohorts WHERE id = $1"
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end


  # def update(user_account)
  # end -->
end



<!-- # 2 Table name: students

# Repository class
# (in lib/Student_repository.rb)
class StudentRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query below:
    sql = "SELECT id, title, content, views, user_account_id FROM students;"
    result_set = DatabaseConnection.exec_params(sql, [])

    students = []

    # loop through results and create an array of user_account objects
    # Return array of user_account objects.
  end

  # Finding one record
  # Taking the record id as an argument
  def find(id)
    sql = "id, title, content, views, user_account_id FROM students WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    # (The code now needs to convert the result to an Album object and return it)
  end


  # Creating a new Student record (takes an instance of Student)
  def create(Student)
    sql = "INSERT INTO students (title, content, views, user_account_id) VALUES($1, $2, $3, $4);"
    params = [Student.title, Student.content, Student.views, Student.user_account_id]
    DatabaseConnection.exec_params(sql, params)
  end


  def delete(id)
    sql = "DELETE FROM students WHERE id = $1"
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end


  # def update(user_account)
  # end
end -->




6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.


# cohorts

# 1 Find cohorts with students - #find_with_students

repo = CohortRepository.new
cohort = repo.find_with_students(1)

expect(cohort.name).to eq 'One'
expect(cohort.starting_date).to eq '2022-09-01'
expect(cohort.students.length).to eq 2
expect(cohort.students.first.name).to eq 'Andy'
expect(cohort.students.last.name).to eq 'James'
expect(cohort.students.first.cohort_id).to eq '1'
expect(cohort.students.last.cohort_id).to eq '1'



<!-- # 1
# Get all cohorts - #all

repo = CohortRepository.new
cohorts = repo.all

expect(cohorts.length).to eq 3
expect(cohorts.first.id).to eq '1'
expect(cohorts.last.id).to eq '3'
expect(cohorts.last.name).to eq 'Scott'


# 2
# Find a user_account - #find(id)

# 1
repo = CohortRepository.new
user_account = repo.find(1)

expect(user_account.id).to eq '1'
expect(user_account.name).to eq 'Andy'
expect(user_account.email_address).to eq 'andy@gmail.com'
expect(user_account.username).to eq 'andy123'

# 2
repo = CohortRepository.new
user_account = repo.find(2)

expect(user_account.id).to eq '2'
expect(user_account.name).to eq 'James'
expect(user_account.email_address).to eq 'james@outlook.com'
expect(user_account.username).to eq 'james456'


# 3
# Delete a user_account
repo = CohortRepository.new

repo.delete(3)
expect(cohorts.length).to eq 2
expect(cohorts.last.id).to eq '2'
expect(cohorts.last.name).to eq 'James'


# 4
# Create a user_account
repo = CohortRepository.new

new_user_account = Cohort.new
new_user_account.name = 'Lewis'
new_user_account.email_address = 'lewis@gmail.com'
new_user_account.username = '1lewis23'

repo.create(new_user_account)

cohorts = repo.all

expect(cohorts.last.id).to eq '4'
expect(cohorts.last.name).to eq 'Lewis'
expect(cohorts.last.email_address).to eq 'lewis@gmail.com'
expect(cohorts.last.username).to eq '1lewis23'




# students

# 1
# Get all students - #all

repo = StudentRepository.new
students = repo.all

expect(students.length).to eq 5
expect(students.first.id).to eq '1'
expect(students.last.id).to eq '5'
expect(students.last.title).to eq 'Deactivate account'
expect(students[2].user_account_id).to eq '3'


# 2
# Find a Student - #find(id)

# 1
repo = StudentRepository.new
Student = repo.find(1)

expect(Student.id).to eq '1'
expect(Student.title).to eq 'Hello'
expect(Student.content).to eq 'Hello, this is Andy'
expect(Student.views).to eq '54'
expect(user_account_id).to eq '1'

# 2
repo = StudentRepository.new
Student = repo.find(2)

expect(Student.id).to eq '2'
expect(Student.title).to eq 'Test'
expect(Student.content).to eq 'Testing, 123'
expect(Student.views).to eq '100'
expect(user_account_id).to eq '2'


# 3
# Delete a Student
repo = StudentRepository.new

repo.delete(3)
expect(students.length).to eq 4
expect(students.last.id).to eq '5' # or 4??? will IDs after deleted one decrement?
expect(students[2].title).to eq 'Sport'


# 4
# Create a Student
repo = StudentRepository.new

new_Student = Student.new
new_Student.title = 'New Student'
new_Student.content = 'I am adding a new Student'
new_Student.views = '2'
new.user_account_id.to eq '2'

repo.create(new_Student)

students = repo.all

expect(students.last.id).to eq '6'
expect(students.last.title).to eq 'New Student'
expect(students.last.content).to eq 'I am adding a new Student'
expect(students.last.views).to eq '2'
expect(user_account_id).to eq '2' -->



<!-- # EXAMPLES

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
Encode this example as a test. -->




7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.


# file: spec/user_account_repository_spec.rb

# Repositry tests
def reset_tables
  seed_sql = File.read('spec/seeds_student_directory_2.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2' })
  connection.exec(seed_sql)
end

describe CohortRepository do
  before(:each) do 
    reset_tables
  end

  # (your tests will go here).
end




8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.
