require_relative 'post'

class PostRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query below:
    sql = "SELECT id, title, content, views, user_account_id FROM posts;"
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    result_set.each do |record|
      post = Post.new
      post.id = record["id"]
      post.title = record["title"]
      post.content = record["content"]
      post.views = record["views"]
      post.user_account_id = record["user_account_id"]

      posts << post
    end

    return posts
  end

  # Finding one record
  # Taking the record id as an argument
  def find(id)
    sql = "SELECT id, title, content, views, user_account_id FROM posts WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    post = Post.new
    post.id = record["id"]
    post.title = record["title"]
    post.content = record["content"]
    post.views = record["views"]
    post.user_account_id = record["user_account_id"]

    return post
  end


  # Creating a new post record (takes an instance of Post)
  def create(post)
    sql = "INSERT INTO posts (title, content, views, user_account_id) VALUES($1, $2, $3, $4);"
    params = [post.title, post.content, post.views, post.user_account_id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end


  def delete(id)
    sql = "DELETE FROM posts WHERE id = $1"
    params = [id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end


  def update(post)
    sql = "UPDATE posts SET title = $1, content = $2, views = $3, user_account_id = $4 WHERE id = $5"
    params = [post.title, post.content, post.views, post.user_account_id, post.id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end
end
