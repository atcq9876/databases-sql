require 'tag_repository'


def reset_tables
  seed_sql = File.read('spec/seeds_blog_posts_tags.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_posts_tags_test' })
  connection.exec(seed_sql)
end

RSpec.describe TagRepository do

  before(:each) do 
    reset_tables
  end

  describe "#find_by_post(post_id)" do
    it "returns all tags from the given post" do
      repo = TagRepository.new
      tags = repo.find_by_post(6)
      
      expect(tags.length).to eq 2
      expect(tags[0].id).to eq '2'
      expect(tags[1].id).to eq '3'
      expect(tags[0].name).to eq 'travel'
      expect(tags[1].name).to eq 'cooking'
    end
  end
end