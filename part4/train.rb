class Train
  attr_reader :number, :speed, :route, :station_index, :type

  def initialize(number, type = 'train')
    @number = number
    @type = type
    @wagons = []
    @speed = 0
  end

  def increase_speed(speed)
    @speed += speed
  end

  def decrease_speed(speed)
    @speed = @speed > speed ? @speed - speed : 0
  end

  def add_wagon(wagon)
    return puts "Error! Cannot add wagon because the train is moving" unless @speed.zero?
    @wagons << wagon
  end

  def delete_wagon(wagon)
    return puts "Error! Cannot delete wagon because the train is moving" unless @speed.zero?
    @wagons.delete(wagon)
  end

  def wagons_number
    @wagons.size
  end

  def add_route(route)
    leave_station if have_route?
    @route = route
    @station_index = 0
    arrive_at_station
  end

  def current_station
    if have_route?
      station(@station_index)
    else
      puts "There is no route for this train"
    end
  end

  def next_station
    return puts "There is no route for this train" unless have_route?
    return puts "The train is in the last station already" if last_station?
    station(@station_index + 1)
  end

  def previous_station
    return puts "There is no route for this train" unless have_route?
    return puts "The train is in the first station already" if first_station?
    station(@station_index - 1)
  end

  def go_to_next_station
    if next_station
      leave_station
      @station_index += 1
      arrive_at_station
    end
  end

  def go_to_previous_station
    if previous_station
      leave_station
      @station_index -= 1   
      arrive_at_station
    end
  end

  protected

  attr_reader :wagons

  def have_route?
    !@route.nil?
  end

  def station(station_index)
    @route.stations[station_index] if have_route?
  end

  def leave_station
    current_station.send_train(self)
  end

  def arrive_at_station
    current_station.add_train(self)
  end
  
  def last_station?
    current_station == @route.last
  end

  def first_station?
    current_station == @route.first
  end
end
