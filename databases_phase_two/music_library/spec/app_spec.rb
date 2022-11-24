require_relative '../app'
require 'artist_repository'
require 'album_repository'

RSpec.describe Application do
  describe "#run" do
    it "outputs and inputs correct values" do
      database_name = "music_library_test"
      io = double :io
      artist_repo = ArtistRepository.new
      album_repo = AlbumRepository.new

      app = Application.new(database_name, io, artist_repo, album_repo)
 
      expect(io).to receive(:puts).with("Welcome to the music library manager!\n")
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with(" 1 - List all artists")
      expect(io).to receive(:puts).with(" 2 - List all albums\n")
      expect(io).to receive(:puts).with("Enter your choice: ")
      expect(io).to receive(:gets).and_return("2")
      expect(io).to receive(:puts).with("Here is the list of albums:")
      expect(io).to receive(:puts).with(" * 1 - Doolittle")
      expect(io).to receive(:puts).with(" * 2 - Surfer Rosa")
      expect(io).to receive(:puts).with(" * 3 - Waterloo")
      expect(io).to receive(:puts).with(" * 4 - Super Trouper")
      expect(io).to receive(:puts).with(" * 5 - Bossanova")
      expect(io).to receive(:puts).with(" * 6 - Lover")
      expect(io).to receive(:puts).with(" * 7 - Folklore")
      expect(io).to receive(:puts).with(" * 8 - I Put a Spell on You")
      expect(io).to receive(:puts).with(" * 9 - Baltimore")
      expect(io).to receive(:puts).with(" * 10 - Here Comes the Sun")
      expect(io).to receive(:puts).with(" * 11 - Fodder on My Wings")


      # app = Application.new(database_name, io, artist_repo, album_repo)
      app.run
    end
  end
end
