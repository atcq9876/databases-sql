require 'comment'
require 'post'
require 'post_repository'

def reset_tables
  seed_sql = File.read('spec/seeds_blog.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_test' })
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do

  before(:each) do 
    reset_tables
  end

  describe "#find_with_comments(id)" do
    it "returns the record of post_id = id, including comments on that post" do
      repo = PostRepository.new
      post = repo.find_with_comments(2)
      
      expect(post.title).to eq 'Second post'
      expect(post.content).to eq 'And this is my second post!'
      expect(post.id).to eq '2'
      expect(post.comments.length).to eq 2
      expect(post.comments.first.content).to eq 'Wow, already onto your second post!'
      expect(post.comments.last.content).to eq 'You are on a role!!!'
      expect(post.comments.first.author_name).to eq 'blogger77'
      expect(post.comments.last.author_name).to eq 'commenter108'
    end
  end
end