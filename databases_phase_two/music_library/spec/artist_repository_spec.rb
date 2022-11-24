require 'artist_repository'

def reset_music_library_tables
  seed_sql = File.read('spec/seeds_music_library.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

RSpec.describe ArtistRepository do
    
  before(:each) do 
    reset_music_library_tables
  end

  describe "#all" do
    it "returns a list of all artists" do
      repo = ArtistRepository.new
      artists = repo.all

      expect(artists.first.id).to eq '1'
      expect(artists.first.name).to eq 'Pixies'
      expect(artists.first.genre).to eq 'Rock'
      expect(artists.last.id).to eq '4'
      expect(artists.last.name).to eq 'Nina Simone'
      expect(artists.last.genre).to eq 'Pop'
    end
  end
end