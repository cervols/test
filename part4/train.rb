class Train  
  attr_accessor :speed, :station
  attr_reader   :number, :type, :wagons_number

  def initialize(number, type = "passenger", wagons_number)
    @number = number
    @type = type
    @wagons_number = wagons_number
    @speed = 0
  end

  def go
    self.speed = 50
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    if speed == 0
      @wagons_number += 1
    else
      puts "Error! Cannot add wagon because the train is moving"
    end
  end

  def delete_wagon
    if @speed == 0
      @wagons_number -= 1
    else
      puts "Error! Cannot delete wagon because the train is moving"
    end
  end

  def add_route(route)
    @route = route
    self.station = @route.start_station
    station.add_train(self)
  end

  def get_whole_route
    if @route != nil
      @route.get_whole_route
    else
      puts "There is no route for this train"
    end
  end

  def get_next_station
    whole_route = get_whole_route
    #return 0 if whole_route is nil
    return 0 if !whole_route

    if @station != whole_route.last
      #find the station number in the route list
      station_number = 0
      whole_route.each_with_index do |station, index|
        if station == @station
          station_number = index + 1
          break
        end
      end
      whole_route[station_number]
    else
      puts "There is no next station because the train is in the end station already"
      whole_route.last
    end
  end

  def get_previous_station
    whole_route = get_whole_route
    #return 0 if whole_route is nil
    return 0 if !whole_route

    if @station != whole_route.first
      #find the number of station in the route list
      station_number = 0
      whole_route.each_with_index do |station, index|
        if station == @station
          station_number = index - 1
          break
        end
      end
      whole_route[station_number]
    else
      puts "There is no previous station because the train is in the start station already"
      whole_route.first
    end
  end

  def show_current_station
    if station
      puts station.name
    else
      puts "The train is in depot"
    end
  end

  def show_next_station
    puts get_next_station.name if get_next_station != 0
  end

  def show_previous_station
    puts get_previous_station.name if get_next_station != 0
  end

  def go_to_next_station
    next_station = get_next_station
    if next_station != 0
      @station.delete_train(self)
      @station = next_station
      @station.add_train(self)
    end
  end

  def go_to_previous_station
    previous_station = get_previous_station
    if previous_station != 0
      @station.delete_train(self)
      @station = previous_station
      @station.add_train(self)
    end
  end
end
