class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def first
    @stations.first
  end

  def last
    @stations.last
  end

  def add_station(station)
    unless @stations.include?(station)
      @stations.insert(-2, station)
    else
      puts "Station #{station.name} is in the route list already"
    end
  end

  def delete_station(station)
    if station == @stations.first || station == @stations.last
      puts "Error! You are trying to delete the start or the end station"
    elsif @stations.include?(station)
      @stations.delete(station)
      puts "Station #{station.name} was removed from the route"
    else
      puts "Error! There is no station #{station.name} in the route list"
    end
  end

  def show_stations
    @stations.each { |station| puts station.name }
  end
end
