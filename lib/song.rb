class Song
  extend Concerns::Findable
  attr_accessor :name, :genre, :artist


  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist != nil
    self.genre = genre if genre != nil
end

  def artist
    @artist
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre
    @genre
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.all
    @@all.uniq
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << self
  end

  def self.new_from_filename(song)
    @@all << self	+    song_parts = song.split(" - ")
    song_name = song_parts[1]
    artist = Artist.find_or_create_by_name(song_parts[0])
    genre = Genre.find_or_create_by_name(song_parts[2].split('.')[0])
    self.create(song_name, artist, genre)
  end


  def self.create(song, artist=nil, genre=nil)
    @@all.clear	+ new_song = Song.new(song, artist, genre)
    new_song.save
    new_song
     end
  end

