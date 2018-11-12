class Train
  include Manufacturer
  include InstanceCounter
  include Validator

  TRAIN_NUMBER_FORMAT = /^[\da-z]{3}\-?[\da-z]{2}$/i
  TRAIN_TYPE_FORMAT   = /^(cargo|passenger)$/i

  attr_reader :number, :type, :wagons, :speed, :route

  def self.find(number)
    @all[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    validate!
    register_instance(@number)
  end

  def all_wagons
    wagons.each { |wagon| yield(wagon) }
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
    leave_station if route?
    @route = route
    @station_index = 0
    arrive_at_station
  end

  def current_station
    station(@station_index) if route?
  end

  def next_station
    station(@station_index + 1) if route? && !last_station?
  end

  def previous_station
    station(@station_index - 1) if route? && !first_station?
  end

  def go_to_next_station
    return unless next_station

    leave_station
    @station_index += 1
    arrive_at_station
  end

  def go_to_previous_station
    return unless previous_station

    leave_station
    @station_index -= 1
    arrive_at_station
  end

  def info
    "#{@number} - #{@type}, number of wagons = #{wagons_number}"
  end

  protected

  attr_reader :station_index

  def validate!
    raise 'Number cannot be nil' if number.nil?
    raise 'Number is too short' if number.length < 4
    raise 'Number has an invalid format' if number !~ TRAIN_NUMBER_FORMAT
    raise "Type can only be 'cargo' or 'passenger'" if type !~ TRAIN_TYPE_FORMAT
  end

  def route?
    !@route.nil?
  end

  def station(station_index)
    @route.stations[station_index] if route?
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
