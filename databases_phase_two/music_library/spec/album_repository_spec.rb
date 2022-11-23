require 'album_repository'

RSpec.describe AlbumRepository do
  
  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_albums_table
  end

  describe "#all" do
    it "returns a list of all albums" do
      repo = AlbumRepository.new
      albums = repo.all

      expect(albums.length).to eq 11
      expect(albums.first.id).to eq '1'
      expect(albums.first.release_year).to eq '1989'
      expect(albums[1].artist_id).to eq '1'
      expect(albums.last.id).to eq '11'
      expect(albums.last.title).to eq 'Fodder on My Wings'
    end
  end

  describe "#find(id)" do
    it "returns the record with id = 3" do
      repo = AlbumRepository.new
      album = repo.find(3)

      expect(album.id).to eq '3'
      expect(album.title).to eq 'Waterloo'
      expect(album.release_year).to eq '1972'
      expect(album.artist_id).to eq '2'
    end

    it "returns the record with id = 1" do
      repo = AlbumRepository.new
      album = repo.find(1)

      expect(album.id).to eq '1'
      expect(album.title).to eq 'Doolittle'
      expect(album.release_year).to eq '1989'
      expect(album.artist_id).to eq '1'
    end
  end
end
