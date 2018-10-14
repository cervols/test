class Station
  include InstanceCounter
  include Validator

  attr_reader :name, :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
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
