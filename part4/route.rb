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
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def delete_station(station)
    return 'Endpoints error' if station == @stations.first || station == @stations.last
    @stations.delete(station)
  end

  def info
    @stations.each { |station| print "#{station.name} " }
    puts
  end
end
