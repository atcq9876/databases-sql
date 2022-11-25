require_relative 'lib/database_connection'
require_relative 'lib/user_account_repository'
require_relative 'lib/user_account'
require_relative 'lib/post_repository'
require_relative 'lib/post'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('social_network')

user_account_repo = UserAccountRepository.new
user_accounts = user_account_repo.all

user_accounts.each do |account|
  p account
end


# new_user_account = UserAccount.new
# new_user_account.name = "Louis"
# new_user_account.email_address = "louis@gmail.com"
# new_user_account.username = "louis345"

# user_account_repo.create(new_user_account)
# user_accounts = user_account_repo.all

# p ""
# user_accounts.each do |account|
#   p account
# end


# updated_account = UserAccount.new
# updated_account.id = "8"
# updated_account.name = "Updated name"
# updated_account.email_address = "update@gmail.com"
# updated_account.username = "update908"

# user_account_repo.update(updated_account)
# user_accounts = user_account_repo.all

# p ""
# user_accounts.each do |account|
#   p account
# end


# user_account_repo.delete(8)
# user_accounts = user_account_repo.all

# p ""
# user_accounts.each do |account|
#   p account
# end


post_repo = PostRepository.new
posts = post_repo.all

p ""
posts.each do |post|
  p post
end


# new_post = Post.new
# new_post.title = "Hi"
# new_post.content = "Hello there"
# new_post.views = 4
# new_post.user_account_id = 1

# post_repo.create(new_post)
# posts = post_repo.all

# p ""
# posts.each do |post|
#   p post
# end


# updated_post = Post.new
# updated_post.id = 6
# updated_post.title = "Updated post"
# updated_post.content = "Update: hi there"
# updated_post.views = 5
# updated_post.user_account_id = 1

# post_repo.update(updated_post)
# posts = post_repo.all

# p ""
# posts.each do |post|
#   p post
# end


# post_repo.delete(6)
# posts = post_repo.all

# p ""
# posts.each do |post|
#   p post
# end