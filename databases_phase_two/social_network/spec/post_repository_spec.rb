require 'post_repository'

def reset_social_network_tables
  seed_sql = File.read('spec/seeds_social_network.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do

  # UserAccountRepositry tests
  before(:each) do 
    reset_social_network_tables
  end

  describe "#all" do
    it "returns all posts" do
      repo = PostRepository.new
      posts = repo.all

      expect(posts.length).to eq 5
      expect(posts.first.id).to eq '1'
      expect(posts.last.id).to eq '5'
      expect(posts.last.title).to eq 'Deactivate account'
      expect(posts[2].user_account_id).to eq '3'
    end
  end

  describe "#find(id)" do
    it "returns the record with id = 1" do
      repo = PostRepository.new
      post = repo.find(1)

      expect(post.id).to eq '1'
      expect(post.title).to eq 'Hello'
      expect(post.content).to eq 'Hello, this is Andy'
      expect(post.views).to eq '54'
      expect(post.user_account_id).to eq '1'
    end

    it "returns the record with id = 2" do
      repo = PostRepository.new
      post = repo.find(2)

      expect(post.id).to eq '2'
      expect(post.title).to eq 'Test'
      expect(post.content).to eq 'Testing, 123'
      expect(post.views).to eq '100'
      expect(post.user_account_id).to eq '2'
    end
  end

  describe "#delete(id)" do
    it "deletes the record with said id" do
      repo = PostRepository.new
      repo.delete(3)
      posts = repo.all

      expect(posts.length).to eq 4
      expect(posts.last.id).to eq '5'
      expect(posts[2].title).to eq 'Sport'
    end
  end

  describe "#create(post)" do
    it "creates a new post" do
      new_post = Post.new
      new_post.title = 'New post'
      new_post.content = 'I am adding a new post'
      new_post.views = '2'
      new_post.user_account_id = '2'
      
      repo = PostRepository.new
      repo.create(new_post)
      posts = repo.all
      
      expect(posts.last.id).to eq '6'
      expect(posts.last.title).to eq 'New post'
      expect(posts.last.content).to eq 'I am adding a new post'
      expect(posts.last.views).to eq '2'
      expect(posts.last.user_account_id).to eq '2'
    end
  end
end
