class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :number, :type, :wagons, :speed, :route

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    @@trains[@number] = self
    register_instance
  end

  def increase_speed(speed)
    @speed += speed
  end

  def decrease_speed(speed)
    @speed = @speed > speed ? @speed - speed : 0
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero?
  end

  def delete_wagon(wagon)
    @wagons.delete(wagon) if @speed.zero?
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
    station(@station_index) if have_route?
  end

  def next_station
    station(@station_index + 1) if have_route? && !last_station?
  end

  def previous_station
    station(@station_index - 1) if have_route? && !first_station?
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

  def info
    "#{@number} - #{@type}, number of wagons = #{self.wagons_number}"
  end

  protected

  attr_reader :station_index

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
    current_station == @route.last_station
  end

  def first_station?
    current_station == @route.first_station
  end
end
