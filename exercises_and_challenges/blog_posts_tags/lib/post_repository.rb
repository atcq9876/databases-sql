require_relative 'post'
require_relative 'tag'

class PostRepository
  def find_by_tag(tag_id)
    sql = "SELECT posts.id AS post_id,
          posts.title AS post_title
          FROM posts
          JOIN posts_tags ON posts.id = posts_tags.post_id
          JOIN tags ON posts_tags.tag_id = tags.id
          WHERE tags.id = $1;"

    params = [tag_id]

    result_set = DatabaseConnection.exec_params(sql, params)
    
    posts = []

    result_set.each do |record|
      post = Post.new
      post.id = record["post_id"]
      post.title = record["post_title"]

      posts << post
    end
    
    return posts
  end
end