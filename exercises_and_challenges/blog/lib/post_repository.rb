require_relative 'post'
require_relative 'comment'

class PostRepository
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

    post = Post.new
    post.id = record["post_id"]
    post.title = record["post_title"]
    post.content = record["post_content"]
    
    result_set.each do |record|
      comment = Comment.new
      comment.id = record["comment_id"]
      comment.content = record["comment"]
      comment.author_name = record["comment_author"]
      
      post.comments << comment
    end

    return post
    # create Post object and add all data (from record)
    # add Comment info to Post.@Comments array (loop through result_set)
    # return Post object    
  end
end