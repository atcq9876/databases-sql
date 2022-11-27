1. Design and create the Table (already done - SKIP)
Otherwise, follow this post to design and create the SQL schema for your table.





2. Create Test SQL seeds
Your tests will depend on data stored in StudentgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- (file: spec/seeds_posts.sql)

-- Write your SQL seed here. 


-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts, posts_tags, tags RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO "posts" (title) VALUES ('How to use Git');
INSERT INTO "posts" (title) VALUES ('Ruby classes');
INSERT INTO "posts" (title) VALUES ('Using IRB');
INSERT INTO "posts" (title) VALUES ('My weekend in Edinburgh');
INSERT INTO "posts" (title) VALUES ('The best chocolate cake EVER');
INSERT INTO "posts" (title) VALUES ('A foodie week in Spain');
INSERT INTO "posts" (title) VALUES ('SQL basics');

INSERT INTO "posts_tags" (post_id, tag_id) VALUES (1, 1),
INSERT INTO "posts_tags" (post_id, tag_id) VALUES (2, 1),
INSERT INTO "posts_tags" (post_id, tag_id) VALUES (3, 1),
INSERT INTO "posts_tags" (post_id, tag_id) VALUES (4, 2),
INSERT INTO "posts_tags" (post_id, tag_id) VALUES (5, 3),
INSERT INTO "posts_tags" (post_id, tag_id) VALUES (6, 2),
INSERT INTO "posts_tags" (post_id, tag_id) VALUES (7, 1),
INSERT INTO "posts_tags" (post_id, tag_id) VALUES (6, 3),
INSERT INTO "posts_tags" (post_id, tag_id) VALUES (2, 4),
INSERT INTO "posts_tags" (post_id, tag_id) VALUES (3, 4);

INSERT INTO "tags" (name) VALUES ('coding');
INSERT INTO "tags" (name) VALUES ('travel');
INSERT INTO "tags" (name) VALUES ('cooking');
INSERT INTO "tags" (name) VALUES ('ruby');


Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 blog_posts_tags_test < seeds_blog_posts_tags.sql







3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.


# 1 Table name: posts

# Model class
# (in lib/post.rb)

class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end




# 2 Table name: tags

# Model class
# (in lib/tag.rb)

class Student
end

# Repository class
# (in lib/tag_repository.rb)
class TagRepository
end






4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.


# 1 Table name: posts

# Model class
# (in lib/post.rb)

class Post
  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :tags

  def initialize
    @tags = []
  end
end


# 2 Table name: tags

# Model class
# (in lib/tags.rb)

class Tag
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :posts

  def intialize
    @posts = []
  end
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


# 1 Table name: posts

# Repository class
# (in lib/post_repository.rb)
class PostRepository
  <!-- # Selecting all records
  # No arguments
  def all
    # Executes the SQL query below:
    sql = "SELECT id, name, email_address, username FROM posts;"
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    # loop through results and create an array of post objects
    # Return array of post objects.
  end -->

  <!-- # Finding one record
  # Taking the record id as an argument
  def find(id)
    sql = "SELECT id, name, email_address, username FROM posts WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    # (The code now needs to convert the result to an Album object and return it)
  end -->


  <!-- # Find one cohort and list tags in this cohort
  # (in lib/cohort_repository.rb)
  def find_with_tags(id)
    sql = "SELECT posts.id AS post_id,
          posts.name AS cohort_name,
          posts.starting_date,
          tags.name AS student_name,
          tags.id AS student_id
          FROM posts
          JOIN tags ON posts.id = tags.post_id
          WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    # create cohort object and add all data (from record)
    # add student info to cohort.@tags array (loop through result_set)
    # return cohort object    
  end -->

  # Find posts by tag
  # (in lib/post_repository.rb)
  def find_by_tag(tag_id)
    sql = "SELECT posts.id AS post_id,
          posts.title AS post_title
          FROM posts
          JOIN posts_tags ON posts.id = posts_tags.post_id
          JOIN tags ON posts_tags.tag_id = tags.id
          WHERE tags.id = $1;"

    params = [tag_id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    
    # create posts (/ @posts) array??
    # loop through records, creating Post objects and adding to posts array?
    # return posts
  end

  <!-- # Creating a new post record (takes an instance of Cohort)
  def create(post)
    sql = "INSERT INTO posts (name, email_address, username) VALUES($1, $2, $3);"
    params = [post.name, post.email_address, post.username]
    DatabaseConnection.exec_params(sql, params)
  end


  def delete(id)
    sql = "DELETE FROM posts WHERE id = $1"
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end


  # def update(post)
  # end -->
end



# 2 Table name: tags

# Repository class
# (in lib/tag_repository.rb)
class TagRepository
  <!-- # Selecting all records
  # No arguments
  def all
    # Executes the SQL query below:
    sql = "SELECT id, title, content, views, post_id FROM tags;"
    result_set = DatabaseConnection.exec_params(sql, [])

    tags = []

    # loop through results and create an array of post objects
    # Return array of post objects.
  end

  # Finding one record
  # Taking the record id as an argument
  def find(id)
    sql = "id, title, content, views, post_id FROM tags WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    # (The code now needs to convert the result to an Album object and return it)
  end -->

  # Find tags by post
  # (in lib/tag_repository.rb)
  def find_by_post(post_id)
    sql = "SELECT tags.id AS tag_id,
          tags.name AS tag_name
          FROM tags
          JOIN posts_tags ON tags.id = posts_tags.tag_id
          JOIN posts ON posts_tags.post_id = posts.id
          WHERE posts.id = $1;"

    params = [post_id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    
    # create tags (/ @tags) array??
    # loop through records, creating Tag objects and adding to tags array?
    # return tags
  end

  <!-- # Creating a new Student record (takes an instance of Student)
  def create(Student)
    sql = "INSERT INTO tags (title, content, views, post_id) VALUES($1, $2, $3, $4);"
    params = [Student.title, Student.content, Student.views, Student.post_id]
    DatabaseConnection.exec_params(sql, params)
  end


  def delete(id)
    sql = "DELETE FROM tags WHERE id = $1"
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end


  # def update(post)
  # end -->
end




6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.


# posts

# Find posts by tag - #find_by_tag

repo = PostRepository.new
posts = repo.find_by_tag(1)

expect(posts.length).to eq 4
expect(posts[0].id).to eq '1'
expect(posts[1].id).to eq '2'
expect(posts[2].id).to eq '3'
expect(posts[3].id).to eq '7'
expect(posts[0].title).to eq 'How to use Git'
expect(posts[1].title).to eq 'Ruby classes'
expect(posts[2].title).to eq 'Using IRB'
expect(posts[3].title).to eq 'SQL basics'

<!-- # Find posts with tags - #find_with_tags

repo = CohortRepository.new
cohort = repo.find_with_tags(1)

expect(cohort.name).to eq 'One'
expect(cohort.starting_date).to eq '2022-09-01'
expect(cohort.tags.length).to eq 2
expect(cohort.tags.first.name).to eq 'Andy'
expect(cohort.tags.last.name).to eq 'James'
expect(cohort.tags.first.post_id).to eq '1'
expect(cohort.tags.last.post_id).to eq '1' -->


<!-- # 1
# Get all posts - #all

repo = CohortRepository.new
posts = repo.all

expect(posts.length).to eq 3
expect(posts.first.id).to eq '1'
expect(posts.last.id).to eq '3'
expect(posts.last.name).to eq 'Scott'


# 2
# Find a post - #find(id)

# 1
repo = CohortRepository.new
post = repo.find(1)

expect(post.id).to eq '1'
expect(post.name).to eq 'Andy'
expect(post.email_address).to eq 'andy@gmail.com'
expect(post.username).to eq 'andy123'

# 2
repo = CohortRepository.new
post = repo.find(2)

expect(post.id).to eq '2'
expect(post.name).to eq 'James'
expect(post.email_address).to eq 'james@outlook.com'
expect(post.username).to eq 'james456'


# 3
# Delete a post
repo = CohortRepository.new

repo.delete(3)
expect(posts.length).to eq 2
expect(posts.last.id).to eq '2'
expect(posts.last.name).to eq 'James'


# 4
# Create a post
repo = CohortRepository.new

new_post = Cohort.new
new_post.name = 'Lewis'
new_post.email_address = 'lewis@gmail.com'
new_post.username = '1lewis23'

repo.create(new_post)

posts = repo.all

expect(posts.last.id).to eq '4'
expect(posts.last.name).to eq 'Lewis'
expect(posts.last.email_address).to eq 'lewis@gmail.com'
expect(posts.last.username).to eq '1lewis23'




# tags

# 1
# Get all tags - #all

repo = StudentRepository.new
tags = repo.all

expect(tags.length).to eq 5
expect(tags.first.id).to eq '1'
expect(tags.last.id).to eq '5'
expect(tags.last.title).to eq 'Deactivate account'
expect(tags[2].post_id).to eq '3'


# 2
# Find a Student - #find(id)

# 1
repo = StudentRepository.new
Student = repo.find(1)

expect(Student.id).to eq '1'
expect(Student.title).to eq 'Hello'
expect(Student.content).to eq 'Hello, this is Andy'
expect(Student.views).to eq '54'
expect(post_id).to eq '1'

# 2
repo = StudentRepository.new
Student = repo.find(2)

expect(Student.id).to eq '2'
expect(Student.title).to eq 'Test'
expect(Student.content).to eq 'Testing, 123'
expect(Student.views).to eq '100'
expect(post_id).to eq '2'


# 3
# Delete a Student
repo = StudentRepository.new

repo.delete(3)
expect(tags.length).to eq 4
expect(tags.last.id).to eq '5' # or 4??? will IDs after deleted one decrement?
expect(tags[2].title).to eq 'Sport'


# 4
# Create a Student
repo = StudentRepository.new

new_Student = Student.new
new_Student.title = 'New Student'
new_Student.content = 'I am adding a new Student'
new_Student.views = '2'
new.post_id.to eq '2'

repo.create(new_Student)

tags = repo.all

expect(tags.last.id).to eq '6'
expect(tags.last.title).to eq 'New Student'
expect(tags.last.content).to eq 'I am adding a new Student'
expect(tags.last.views).to eq '2'
expect(post_id).to eq '2' -->



# tags


# Find tags by post - #find_by_post

repo = TagRepository.new
tags = repo.find_by_post(6)

expect(tags.length).to eq 2
expect(tags[0].id).to eq '2'
expect(tags[1].id).to eq '3'
expect(tags[0].name).to eq 'travel'
expect(tags[1].name).to eq 'cooking'





<!-- # EXAMPLES

# 1
# Get all tags

repo = StudentRepository.new

tags = repo.all

tags.length # =>  2

tags[0].id # =>  1
tags[0].name # =>  'David'
tags[0].cohort_name # =>  'April 2022'

tags[1].id # =>  2
tags[1].name # =>  'Anna'
tags[1].cohort_name # =>  'May 2022'

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


# file: spec/post_repository_spec.rb

# Repository tests
def reset_tables
  seed_sql = File.read('spec/seeds_blog_posts_tags.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_posts_tags_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_tables
  end

  # (your tests will go here).
end




8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.
