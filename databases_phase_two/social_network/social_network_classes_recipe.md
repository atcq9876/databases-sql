1. Design and create the Table
Otherwise, follow this user_account to design and create the SQL schema for your table.

See 'social_network_tables_user_account.md'




2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- (file: spec/seeds_user_accounts.sql)

-- Write your SQL seed here. 


# 1 user_accounts_table
-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE user_accounts RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO "user_accounts" (name, email_address, username) VALUES ('Andy', 'andy@gmail.com', 'andy123');
INSERT INTO "user_accounts" (name, email_address, username) VALUES ('James', 'james@outlook.com', 'james456');
INSERT INTO "user_accounts" (name, email_address, username) VALUES ('Scott', 'scott@outlook.com', '789scott');

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 social_network_test < seeds_user_accounts.sql


# 2 posts_table
-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO "posts" (title, content, views, user_account_id) VALUES ('Hello', 'Hello, this is Andy', 54, 1);
INSERT INTO "posts" (title, content, views, user_account_id) VALUES ('Test', 'Testing, 123', 100, 2);
INSERT INTO "posts" (title, content, views, user_account_id) VALUES ('Dinner', 'I ate pizza for dinner', 230, 3);
INSERT INTO "posts" (title, content, views, user_account_id) VALUES ('Sport', 'My favourite sport is tennis', 77, 3);
INSERT INTO "posts" (title, content, views, user_account_id) VALUES ('Deactivate account', 'I am thinking of deactivating my account', 900, 1);


Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 social_network_test < seeds_posts.sql




3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.


# 1 Table name: user_accounts

# Model class
# (in lib/user_account.rb)

class UserAccount
end

# Repository class
# (in lib/user_account_repository.rb)
class UserAccountRepository
end




# 2 Table name: posts

# Model class
# (in lib/posts.rb)

class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end






4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.


# 1 Table name: user_accounts

# Model class
# (in lib/user_account.rb)

class UserAccount
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :email_address, :username
end


# 2 Table name: posts

# Model class
# (in lib/posts.rb)

class Post
  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :views, :user_account_id
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


# 1 Table name: user_accounts

# Repository class
# (in lib/user_account_repository.rb)
class UserAccountRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query below:
    sql = "SELECT id, name, email_address, username FROM user_accounts;"
    result_set = DatabaseConnection.exec_params(sql, [])

    user_accounts = []

    # loop through results and create an array of user_account objects
    # Return array of user_account objects.
  end

  # Finding one record
  # Taking the record id as an argument
  def find(id)
    sql = "SELECT id, name, email_address, username FROM user_accounts WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    # (The code now needs to convert the result to an Album object and return it)
  end

  # Creating a new user_account record (takes an instance of UserAccount)
  def create(user_account)
    sql = "INSERT INTO user_accounts (name, email_address, username) VALUES($1, $2, $3);"
    params = [user_account.name, user_account.email_address, user_account.username]
    DatabaseConnection.exec_params(sql, params)
  end


  def delete(id)
    sql = "DELETE FROM user_accounts WHERE id = $1"
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end


  # def update(user_account)
  # end
end



# 2 Table name: posts

# Repository class
# (in lib/post_repository.rb)
class PostRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query below:
    sql = "SELECT id, title, content, views, user_account_id FROM posts;"
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    # loop through results and create an array of user_account objects
    # Return array of user_account objects.
  end

  # Finding one record
  # Taking the record id as an argument
  def find(id)
    sql = "id, title, content, views, user_account_id FROM posts WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    # (The code now needs to convert the result to an Album object and return it)
  end


  # Creating a new post record (takes an instance of Post)
  def create(post)
    sql = "INSERT INTO posts (title, content, views, user_account_id) VALUES($1, $2, $3, $4);"
    params = [post.title, post.content, post.views, post.user_account_id]
    DatabaseConnection.exec_params(sql, params)
  end


  def delete(id)
    sql = "DELETE FROM posts WHERE id = $1"
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end


  # def update(user_account)
  # end
end







6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.


# USER_ACCOUNTS
# 1
# Get all user_accounts - #all

repo = UserAccountRepository.new
user_accounts = repo.all

expect(user_accounts.length).to eq 3
expect(user_accounts.first.id).to eq '1'
expect(user_accounts.last.id).to eq '3'
expect(user_accounts.last.name).to eq 'Scott'


# 2
# Find a user_account - #find(id)


<!-- INSERT INTO "user_accounts" (name, email_address, username) VALUES ('Andy', 'andy@gmail.com', 'andy123');
INSERT INTO "user_accounts" (name, email_address, username) VALUES ('James', 'james@outlook.com', 'james456');
INSERT INTO "user_accounts" (name, email_address, username) VALUES ('Scott', 'scott@outlook.com', '789scott'); -->

# 1
repo = UserAccountRepository.new
user_account = repo.find(1)

expect(user_account.id).to eq '1'
expect(user_account.name).to eq 'Andy'
expect(user_account.email_address).to eq 'andy@gmail.com'
expect(user_account.username).to eq 'andy123'

# 2
repo = UserAccountRepository.new
user_account = repo.find(2)

expect(user_account.id).to eq '2'
expect(user_account.name).to eq 'James'
expect(user_account.email_address).to eq 'james@outlook.com'
expect(user_account.username).to eq 'james456'


# 3
# Delete a user_account
repo = UserAccountRepository.new

repo.delete(3)
expect(user_accounts.length).to eq 2
expect(user_accounts.last.id).to eq '2'
expect(user_accounts.last.name).to eq 'James'


# 4
# Create a user_account
repo = UserAccountRepository.new

new_user_account = UserAccount.new
new_user_account.name = 'Lewis'
new_user_account.email_address = 'lewis@gmail.com'
new_user_account.username = '1lewis23'

repo.create(new_user_account)

user_accounts = repo.all

expect(user_accounts.last.id).to eq '4'
expect(user_accounts.last.name).to eq 'Lewis'
expect(user_accounts.last.email_address).to eq 'lewis@gmail.com'
expect(user_accounts.last.username).to eq '1lewis23'




# POSTS

<!-- INSERT INTO "posts" (title, content, views, user_account_id) VALUES ('Hello', 'Hello, this is Andy', 54, 1);
INSERT INTO "posts" (title, content, views, user_account_id) VALUES ('Test', 'Testing, 123', 100, 2);
INSERT INTO "posts" (title, content, views, user_account_id) VALUES ('Dinner', 'I ate pizza for dinner', 230, 3);
INSERT INTO "posts" (title, content, views, user_account_id) VALUES ('Sport', 'My favourite sport is tennis', 77, 3);
INSERT INTO "posts" (title, content, views, user_account_id) VALUES ('Deactivate account', 'I am thinking of deactivating my account', 900, 1); -->

# 1
# Get all posts - #all

repo = PostRepository.new
posts = repo.all

expect(posts.length).to eq 5
expect(posts.first.id).to eq '1'
expect(posts.last.id).to eq '5'
expect(posts.last.title).to eq 'Deactivate account'
expect(posts[2].user_account_id).to eq '3'


# 2
# Find a post - #find(id)

# 1
repo = PostRepository.new
post = repo.find(1)

expect(post.id).to eq '1'
expect(post.title).to eq 'Hello'
expect(post.content).to eq 'Hello, this is Andy'
expect(post.views).to eq '54'
expect(user_account_id).to eq '1'

# 2
repo = PostRepository.new
post = repo.find(2)

expect(post.id).to eq '2'
expect(post.title).to eq 'Test'
expect(post.content).to eq 'Testing, 123'
expect(post.views).to eq '100'
expect(user_account_id).to eq '2'


# 3
# Delete a post
repo = PostRepository.new

repo.delete(3)
expect(posts.length).to eq 4
expect(posts.last.id).to eq '5' # or 4??? will IDs after deleted one decrement?
expect(posts[2].title).to eq 'Sport'


# 4
# Create a post
repo = PostRepository.new

new_post = Post.new
new_post.title = 'New post'
new_post.content = 'I am adding a new post'
new_post.views = '2'
new.user_account_id.to eq '2'

repo.create(new_post)

posts = repo.all

expect(posts.last.id).to eq '6'
expect(posts.last.title).to eq 'New post'
expect(posts.last.content).to eq 'I am adding a new post'
expect(posts.last.views).to eq '2'
expect(user_account_id).to eq '2'



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

# UserAccountRepositry tests
def reset_user_accounts_table
  seed_sql = File.read('spec/seeds_user_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

# PostRepository tests
def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

# UserAccountRepositry tests
describe UserAccountRepository do
  before(:each) do 
    reset_user_accounts_table
  end

  # (your tests will go here).
end

# PostRepository tests
describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end





8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.
