class TelevisionShow

  attr_reader :title, :network, :starting_year, :genre, :synopsis, :errors

  GENRES = ["Action", "Mystery", "Drama", "Comedy", "Fantasy"]

  class << self
    def all
      television_shows = []
      open_file = File.open("television-shows.csv", "r")

      CSV.foreach(open_file, headers: true) do |show|
        title         = show[0]
        network       = show[1]
        starting_year = show[2]
        synopsis      = show[3]
        genre         = show[4]

        television_shows << TelevisionShow.new(title, network, starting_year, synopsis, genre)
      end
      television_shows
    end

    def list_genres
      GENRES
    end
  end

  def initialize(title, network, starting_year, synopsis, genre)
    @title         = title
    @network       = network
    @starting_year = starting_year
    @synopsis      = synopsis
    @genre         = genre
  end

  def blank_entries?
    if @title != "" &&
      @network != "" &&
      @starting_year != "" &&
      @synopsis != "" &&
      @genre != ""
      return false
    else
      return true
    end
  end

  def is_show_unique?
    saved_shows    = self.class.all
    show_is_unique = false

    saved_shows.each do |show|
      if show.title == @title
        show_is_unique = true
        break
      end
    end
    show_is_unique
  end

  def errors
    errors = []
    if blank_entries?
      errors << "Please fill in all required fields!"
    end
    if is_show_unique?
      errors << "That show has already been added!"
    end
    errors
  end

  def valid?
    if blank_entries? == false && is_show_unique? == false
      return true
    else
      return false
    end
  end

  def save
    if valid?
      CSV.open('television-shows.csv', 'a') do |file|
        data = [@title, @network, @starting_year, @synopsis, @genre]
        file.puts(data)
      end
      true
    else
      false
    end
  end
end
