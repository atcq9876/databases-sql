1. Design and create the Table
Otherwise, follow this post to design and create the SQL schema for your table.

See 'blog_tables_recipe.md'




2. Create Test SQL seeds
Your tests will depend on data stored in CommentgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- (file: spec/seeds_blog.sql)

-- Write your SQL seed here. 


# 1 blog_tables
-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts, comments RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content) VALUES ('First post', 'Hi everyone, this is my first blog post!');
INSERT INTO posts (title, content) VALUES ('Second post', 'And this is my second post!');

INSERT INTO comments (content, author_name, post_id) VALUES ('Welcome to this blogging site!', 'tony_123', 1);
INSERT INTO comments (content, author_name, post_id) VALUES ('Great post!!', 'author22', 1);
INSERT INTO comments (content, author_name, post_id) VALUES ('Wow, already onto your second post!', 'blogger77', 2);
INSERT INTO comments (content, author_name, post_id) VALUES ('You are on a role!!!', 'commenter108', 2);


Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 blog_test < seeds_blog.sql




3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.


# 1 Table name: post

# Model class
# (in lib/post.rb)

class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end




# 2 Table name: comments

# Model class
# (in lib/comment.rb)

class Comment
end

# Repository class
# (in lib/comment_repository.rb)
class CommentRepository
end






4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.


# 1 Table name: posts

# Model class
# (in lib/post.rb)

class Post
  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :comments

  def initialize
    @comments = []
  end
end


# 2 Table name: Comments

# Model class
# (in lib/Comments.rb)

class Comment
  # Replace the attributes by your own columns.
  attr_accessor :id, :content, :author_name, :post_id
end


# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# Comment = Comment.new
# Comment.name = 'Jo'
# Comment.name
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


  # Find one Ppst and list comments from this post
  # (in lib/post_repository.rb)
  def find_with_comments(id)
    sql = "SELECT posts.id AS post_id,
          posts.title AS post_title,
          posts.content AS post_content,
          comments.content AS comment,
          comments.author_name AS comment_author,
          comments.id AS comment_id
          FROM posts
          JOIN comments ON posts.id = comments.post_id
          WHERE posts.id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    # create Post object and add all data (from record)
    # add Comment info to Post.@Comments array (loop through result_set)
    # return Post object    
  end

  <!-- # Creating a new post record (takes an instance of Post)
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



<!-- # 2 Table name: Comments

# Repository class
# (in lib/Comment_repository.rb)
class CommentRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query below:
    sql = "SELECT id, title, content, views, post_id FROM Comments;"
    result_set = DatabaseConnection.exec_params(sql, [])

    Comments = []

    # loop through results and create an array of post objects
    # Return array of post objects.
  end

  # Finding one record
  # Taking the record id as an argument
  def find(id)
    sql = "id, title, content, views, post_id FROM Comments WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    # (The code now needs to convert the result to an Album object and return it)
  end


  # Creating a new Comment record (takes an instance of Comment)
  def create(Comment)
    sql = "INSERT INTO Comments (title, content, views, post_id) VALUES($1, $2, $3, $4);"
    params = [Comment.title, Comment.content, Comment.views, Comment.post_id]
    DatabaseConnection.exec_params(sql, params)
  end


  def delete(id)
    sql = "DELETE FROM Comments WHERE id = $1"
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end


  # def update(post)
  # end
end -->




6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.


# posts

# 1 Find posts with Comments - #find_with_Comments

repo = PostRepository.new
post = repo.find_with_comments(2)

expect(post.title).to eq 'Second post'
expect(post.content).to eq 'And this is my second post!'
expect(post.id).to eq '2'
expect(post.comments.length).to eq 2
expect(post.comments.first.content).to eq 'Wow, already onto your second post!'
expect(post.comments.last.content).to eq 'You are on a role!!!'
expect(post.comments.last.author_name).to eq 'blogger77'
expect(post.comments.last.author_name).to eq 'commenter108'
expect(post.comments.first.post_id).to eq '2'
expect(post.comments.last.post_id).to eq '2'



<!-- # 1
# Get all posts - #all

repo = PostRepository.new
posts = repo.all

expect(posts.length).to eq 3
expect(posts.first.id).to eq '1'
expect(posts.last.id).to eq '3'
expect(posts.last.name).to eq 'Scott'


# 2
# Find a post - #find(id)

# 1
repo = PostRepository.new
post = repo.find(1)

expect(post.id).to eq '1'
expect(post.name).to eq 'Andy'
expect(post.email_address).to eq 'andy@gmail.com'
expect(post.username).to eq 'andy123'

# 2
repo = PostRepository.new
post = repo.find(2)

expect(post.id).to eq '2'
expect(post.name).to eq 'James'
expect(post.email_address).to eq 'james@outlook.com'
expect(post.username).to eq 'james456'


# 3
# Delete a post
repo = PostRepository.new

repo.delete(3)
expect(posts.length).to eq 2
expect(posts.last.id).to eq '2'
expect(posts.last.name).to eq 'James'


# 4
# Create a post
repo = PostRepository.new

new_post = Post.new
new_post.name = 'Lewis'
new_post.email_address = 'lewis@gmail.com'
new_post.username = '1lewis23'

repo.create(new_post)

posts = repo.all

expect(posts.last.id).to eq '4'
expect(posts.last.name).to eq 'Lewis'
expect(posts.last.email_address).to eq 'lewis@gmail.com'
expect(posts.last.username).to eq '1lewis23'




# Comments

# 1
# Get all Comments - #all

repo = CommentRepository.new
Comments = repo.all

expect(Comments.length).to eq 5
expect(Comments.first.id).to eq '1'
expect(Comments.last.id).to eq '5'
expect(Comments.last.title).to eq 'Deactivate account'
expect(Comments[2].post_id).to eq '3'


# 2
# Find a Comment - #find(id)

# 1
repo = CommentRepository.new
Comment = repo.find(1)

expect(Comment.id).to eq '1'
expect(Comment.title).to eq 'Hello'
expect(Comment.content).to eq 'Hello, this is Andy'
expect(Comment.views).to eq '54'
expect(post_id).to eq '1'

# 2
repo = CommentRepository.new
Comment = repo.find(2)

expect(Comment.id).to eq '2'
expect(Comment.title).to eq 'Test'
expect(Comment.content).to eq 'Testing, 123'
expect(Comment.views).to eq '100'
expect(post_id).to eq '2'


# 3
# Delete a Comment
repo = CommentRepository.new

repo.delete(3)
expect(Comments.length).to eq 4
expect(Comments.last.id).to eq '5' # or 4??? will IDs after deleted one decrement?
expect(Comments[2].title).to eq 'Sport'


# 4
# Create a Comment
repo = CommentRepository.new

new_Comment = Comment.new
new_Comment.title = 'New Comment'
new_Comment.content = 'I am adding a new Comment'
new_Comment.views = '2'
new.post_id.to eq '2'

repo.create(new_Comment)

Comments = repo.all

expect(Comments.last.id).to eq '6'
expect(Comments.last.title).to eq 'New Comment'
expect(Comments.last.content).to eq 'I am adding a new Comment'
expect(Comments.last.views).to eq '2'
expect(post_id).to eq '2' -->



<!-- # EXAMPLES

# 1
# Get all Comments

repo = CommentRepository.new

Comments = repo.all

Comments.length # =>  2

Comments[0].id # =>  1
Comments[0].name # =>  'David'
Comments[0].Post_name # =>  'April 2022'

Comments[1].id # =>  2
Comments[1].name # =>  'Anna'
Comments[1].Post_name # =>  'May 2022'

# 2
# Get a single Comment

repo = CommentRepository.new

Comment = repo.find(1)

Comment.id # =>  1
Comment.name # =>  'David'
Comment.Post_name # =>  'April 2022'

# Add more examples for each method
Encode this example as a test. -->




7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.


# file: spec/post_repository_spec.rb

# Repositry tests
def reset_tables
  seed_sql = File.read('spec/seeds_blog.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_test' })
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
