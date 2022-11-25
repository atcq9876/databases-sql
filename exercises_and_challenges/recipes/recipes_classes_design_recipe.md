1. Design and create the Table
Otherwise, follow this recipe to design and create the SQL schema for your table.

See 'recipes_table_design_recipe.md'




2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- (file: spec/seeds_recipes.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE recipes RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO "recipes" (recipe_name, cooking_time, rating) VALUES ('Margherita Pizza', '30 mins');
INSERT INTO "recipes" (recipe_name, cooking_time, rating) VALUES ('Spaghetti Bolognese', '20 mins');
INSERT INTO "recipes" (recipe_name, cooking_time, rating) VALUES ('Mushroom Risotto', '45 mins');


Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 your_database_name < seeds_{recipes_directory_test}.sql




3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.


# Table name: recipes

# Model class
# (in lib/recipe.rb)

class Recipe
end

# Repository class
# (in lib/recipe_repository.rb)
class RecipeRepository
end




4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.



# Table name: recipes

# Model class
# (in lib/recipe.rb)

class Recipe

  # Replace the attributes by your own columns.
  attr_accessor :id, :recipe_name, :cooking_time, :rating
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


# Table name: recipes

# Repository class
# (in lib/recipe_repository.rb)
class RecipeRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query below:
    sql = "SELECT id, recipe_name, cooking_time, rating FROM recipes;"
    result_set = DatabaseConnection.exec_params(sql, [])

    results = []

    # loop through results and create an array of Recipe objects
    # Return array of Recipe objects.
  end

  # Finding one record
  # Taking the record id as an argument
  def find(id)
    sql = "SELECT id, recipe_name, cooking_time, rating FROM recipes WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    # (The code now needs to convert the result to an Album object and return it)
  end
end




6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# 1
# Get all recipes - #all

repo = RecipeRepository.new
recipes = repo.all

  expect(recipes.length).to eq 3
  expect(recipes.first.id).to eq '1'
  expect(recipes.last.id).to eq '3'
  expect(recipes.last.recipe_name).to eq 'Margherita Pizza'


# 2
# Find a recipe - #find(id)

# 1
repo = RecipeRepository.new
recipe = repo.find(1)

  expect(recipe.id).to eq '1'
  expect(recipe.recipe_name).to eq 'Margherita Pizza'
  expect(recipe.cooking_time).to eq '30'
  expect(recipe.rating).to eq '4'

# 2

repo = RecipeRepository.new
recipe = repo.find(2)

  expect(recipe.id).to eq '2'
  expect(recipe.recipe_name).to eq 'Spaghetti Bolognese'
  expect(recipe.cooking_time).to eq '20'
  expect(recipe.rating).to eq '3'



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


# file: spec/recipe_repository_spec.rb

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  # (your tests will go here).
end




8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.
