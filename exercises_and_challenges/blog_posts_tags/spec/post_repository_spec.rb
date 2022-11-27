require 'post_repository'


def reset_tables
  seed_sql = File.read('spec/seeds_blog_posts_tags.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_posts_tags_test' })
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do

  before(:each) do 
    reset_tables
  end

  describe "#find_by_tag(tag_id)" do
    it "returns all posts with the given tag" do
      repo = PostRepository.new
      posts = repo.find_by_tag(1)
      
      expect(posts.length).to eq 4
      expect(posts[0].id).to eq '1'
      expect(posts[1].id).to eq '2'
      expect(posts[2].id).to eq '3'
      expect(posts[3].id).to eq '7'
      expect(posts[0].title).to eq 'How to use Git'
      expect(posts[1].title).to eq 'Ruby classes'
      expect(posts[2].title).to eq 'Using IRB'
      expect(posts[3].title).to eq 'SQL basics'
    end
  end
end