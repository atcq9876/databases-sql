require 'album_repository'

def reset_music_library_tables
  seed_sql = File.read('spec/seeds_music_library.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

RSpec.describe AlbumRepository do
    
  before(:each) do 
    reset_music_library_tables
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

  describe "#create(album)" do
    it "adds a new album to the albums table" do
      repo = AlbumRepository.new

      new_album = Album.new
      new_album.title = 'Indie Cindy'
      new_album.release_year = '2014'
      new_album.artist_id = '1'
      
      repo.create(new_album)
      
      albums = repo.all
      
      expect(albums.last.id).to eq '12'
      expect(albums.last.title).to eq 'Indie Cindy'
      expect(albums.last.release_year).to eq '2014'
      expect(albums.last.artist_id).to eq '1'
    end
  end
end