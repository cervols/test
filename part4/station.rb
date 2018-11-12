class Station
  include InstanceCounter
  include Validator

  STATION_NAME_FORMAT = /^[a-z][a-z\-? ?]*[a-z]$/i

  attr_reader :name, :trains

  class << self
    alias find all
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    register_instance(@name)
  end

  def all_trains
    trains.each { |train| yield(train) }
  end

  def add_train(train)
    @trains << train unless @trains.include?(train)
  end

  def type_trains(type)
    @trains.select { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end

  def info
    "#{@name}, trains on station - #{@trains.size}"
  end

  private

  def validate!
    raise 'Name cannot be blank' if name.empty?
    raise 'Name is too short' if name.length < 3
    raise 'Name is invalid' if name !~ STATION_NAME_FORMAT
  end
end
