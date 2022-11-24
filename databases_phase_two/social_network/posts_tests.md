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