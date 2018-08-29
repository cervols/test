class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def type_trains(type)
    @trains.select { |train| train.type == type }
  end

  def add_train(train)
    @trains << train if correct_station?(train)
  end

  def send_train(train)
    @trains.delete(train) if correct_station?(train)
  end 

  private

  def correct_station?(train)
    train.route.stations[train.station_index] == self
  end

end
