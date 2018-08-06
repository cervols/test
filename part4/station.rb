class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    if @trains.include?(train)
      puts "This train is at the #{@name} already"
    else
      @trains << train
    end
  end

  def type_trains(type)
    @trains.select { |train| train.type == type }
  end

  def send_train(train)
    if !@trains.include?(train)
      puts "Error! This train is not at the #{@name} station"
    else
      @trains.delete(train)
    end
  end  
end
