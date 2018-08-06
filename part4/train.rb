class Train
  attr_reader   :number, :type, :wagons, :speed, :station_index

  def initialize(number, type = "passenger", wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def increase_speed(speed)
    @speed += speed
  end

  def decrease_speed(speed)
    (@speed = @speed - speed) > 0 ? @speed : @speed = 0
  end

  def add_wagon
    return puts "Error! Cannot add wagon because the train is moving" if @speed != 0
    @wagons += 1
  end

  def delete_wagon
    return puts "Error! Cannot delete wagon because the train is moving" if @speed != 0
    @wagons -= 1 if @wagons > 0
  end

  def add_route(route)
    @route = route
    @station_index = 0
    @route.stations.first.add_train(self)
  end

  def get_station(station_index)
    @route.stations[station_index] if @route
  end

  def get_current_station
    if @route
      get_station(@station_index)
    else
      puts "There is no route for this train"
    end
  end

  def get_next_station
    return puts "There is no route for this train" unless @route
    if station = get_station(@station_index + 1)
      station
    else
      puts "There is no next station because the train is in the end station already"
    end
  end

  def get_previous_station
    return puts "There is no route for this train" unless @route
    return puts "The train is in the start station already" if @station_index == 0
    if station = get_station(@station_index - 1)
      station
    else
      puts "There is no previous station because the train is in the start station already"
    end
  end

  def go_to_next_station
    next_station = get_next_station
    if next_station
      @route.stations[@station_index].send_train(self)
      @station_index += 1
      next_station.add_train(self)
    end
  end

  def go_to_previous_station
    previous_station = get_previous_station
    if previous_station
      @route.stations[@station_index].send_train(self)
      @station_index -= 1
      previous_station.add_train(self)
    end
  end
end
