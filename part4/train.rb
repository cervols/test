class Train  
  attr_accessor :speed, :station
  attr_reader   :number, :type, :wagons_number

  def initialize(number, type = "passenger", wagons_number)
    @number = number
    @type = type
    @wagons_number = wagons_number
    @speed = 0
    @station = 'depot'
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
    #@route = route
    @whole_route = route.get_whole_route
    @station = @whole_route.first
    #@station.add_train(self)
  end

  def get_next_station
    if @whole_route == nil
      puts "There is now route for this train"
    elsif @station != @whole_route.last
      @whole_route[@whole_route.index(@station) + 1]
    else
      @whole_route.last
    end
  end

  def get_previous_station
    if @whole_route == nil
      puts "There is now route for this train"
    elsif @station != @whole_route.first
      @whole_route[@whole_route.index(@station) - 1]
    else
      @whole_route.first
    end
  end

  def show_next_station
    puts get_next_station
  end

  def show_previous_station
    puts get_previous_station
  end

  def go_to_next_station
    @station = get_next_station
  end

  def go_to_previous_station
    @station = get_previous_station
  end
end
