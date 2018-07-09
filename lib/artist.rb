class Artist
extend Concerns::Findable
  attr_accessor :name, :songs, :genres

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << self unless @@all.include?(self) 
  end

  def self.create(artist)
    artist = Artist.new(artist) 
    artist.save
    artist
  end 
  
  def add_song(song)
    if song.artist == nil
      song.artist = self
    end

    if !@songs.include?(song)
      @songs << song
    end
  end

  def genres
    self.songs.map { |song| song.genre}.uniq
  end

end
