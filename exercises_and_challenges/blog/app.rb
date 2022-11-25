require_relative 'lib/database_connection'
require_relative 'lib/comment'
require_relative 'lib/post'
require_relative 'lib/post_repository'

DatabaseConnection.connect('blog')

repo = PostRepository.new
post = repo.find_with_comments(2)

p "Post ID: #{post.id}"
p "Post title: #{post.title}"
p "Post content: #{post.content}"
p "Post comments:"

# p post.comments.first.content
post.comments.each do |comment|
  p "#{comment.content} (author: #{comment.author_name})"
end