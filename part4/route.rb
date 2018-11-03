class Route
  include InstanceCounter
  include Validator

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
    register_instance
  end

  def first_station
    @stations.first
  end

  def last_station
    @stations.last
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def delete_station(station)
    return if [first_station, last_station].include?(station)
    @stations.delete(station)
  end

  private

  def validate!
    raise "Station/s is invalid" unless stations.all?{ |station| station.is_a?(Station) }
    raise "Start and last station cannot be the same" if stations.first.name == stations.last.name
  end
end
