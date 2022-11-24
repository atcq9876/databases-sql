require_relative 'post'

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

  # # Finding one record
  # # Taking the record id as an argument
  # def find(id)
  #   sql = "id, title, content, views, user_account_id FROM posts WHERE id = $1;"

  #   params = [id]

  #   result_set = DatabaseConnection.exec_params(sql, params)
  #   record = result_set[0]

  #   # (The code now needs to convert the result to an Album object and return it)
  # end


  # # Creating a new post record (takes an instance of Post)
  # def create(post)
  #   sql = "INSERT INTO posts (title, content, views, user_account_id) VALUES($1, $2, $3, $4);"
  #   params = [post.title, post.content, post.views, post.user_account_id]
  #   DatabaseConnection.exec_params(sql, params)
  # end


  # def delete(id)
  #   sql = "DELETE FROM posts WHERE id = $1"
  #   params = [id]
  #   DatabaseConnection.exec_params(sql, params)
  # end


  # # def update(user_account)
  # # end
end