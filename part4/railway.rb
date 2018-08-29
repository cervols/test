class RailWay
  attr_reader :stations, :routes, :trains, :wagons

  def initialize
    @stations = []
    @routes   = []
    @trains   = []
    @wagons   = []
  end

  def find_station(station_name)
    @stations.find { |station| station.name.downcase == station_name.downcase }
  end

  def find_route(start_station_name, end_station_name)
    @routes.find { |route| route.first.name.downcase == start_station_name.downcase &&
      route.last.name.downcase == end_station_name.downcase }
  end

  def find_train(train_number)
    @trains.find { |train| train.number.downcase == train_number.downcase }
  end

  def find_wagon(wagon_number)
    @wagons.find { |wagon| wagon.number.downcase == wagon_number.downcase }
  end
end
