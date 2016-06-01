require "csv"

class TelevisionShow
  GENRES = ["action", "mystery", "drama", "comedy", "fantasy"]
  attr_reader :title, :network, :starting_year, :genre, :synopsis, :errors

  def initialize(title, network, starting_year, genre, synopsis)
    @title = title
    @network = network
    @starting_year = starting_year
    @genre = genre
    @synopsis = synopsis
    @errors = []
  end

  def valid?(csv_file)
    if @title.length == 0 || @network.length == 0 || @starting_year.length == 0 || @genre.length == 0 || @synopsis.length == 0
      @errors << "Please fill in all required fields"
      false
    else
      CSV.foreach(csv_file) do |line|
        if line[0] == @title
          @errors << "The show has already been added"
          return false
        end
      end
      true
    end
  end

  def save(csv_file)
    if valid?(csv_file)
      File.open(csv_file, 'a') do |file|
        file.puts(@title + ',' + @network + ',' + @starting_year + ',' + @genre + ',' + @synopsis)
      end
      true
    else
      false
    end
  end

  def self.all(csv_file)
    all_shows = []
    CSV.foreach(csv_file) do |row|
      all_shows << TelevisionShow.new(row[0], row[1], row[2], row[3], row[4])
    end
    all_shows
  end

  def check_genre
    GENRES.include?(@genre)
  end

end
