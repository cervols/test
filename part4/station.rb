class Station
  include InstanceCounter
  include Validation

  STATION_NAME_FORMAT = /^[a-z][a-z\-? ?]*[a-z]$/i

  attr_reader :name, :trains

  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, STATION_NAME_FORMAT

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
end
