class Route
  attr_reader :station_list, :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @station_list = []
  end

  def add_station(station)
    if !@station_list.include?(station)
      @station_list << station
    else
      puts "Station #{station} is in the route list already"
    end
  end

  def delete_station(station)
    if @station_list.include?(station)
      @station_list.delete(station)
    else
      puts "Error! There is no station #{station.name} in the route list"
    end
  end

  def get_whole_route
    whole_route = [start_station]
    station_list.each { |station| whole_route << station } 
    whole_route << end_station
  end

  def show_stations
    puts "Stations:"
    get_whole_route.each { |station| puts station.name }
  end
end
