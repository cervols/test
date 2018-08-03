class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    if @trains.include?(train)
      puts "Error! This train is in the #{@name} already"
    else
      @trains << train
      train.station = self
    end
  end

  def delete_train(train)
    if !@trains.include?(train)
      puts "Error! This train is not in the #{@name} station"
    else
      @trains.delete(train)
    end
  end

  def send_train(train)
    if !@trains.include?(train)
      puts "Error! This train is not in the #{@name} station"
    else
      train.go_to_next_station
    end
  end

  def show_trains
    @trains.each { |train| puts "#{train.number} - #{train.type} - " +
      "#{train.wagons_number} wagons" }
  end

  def show_type_trains
    pass_trains, freight_trains = @trains.partition { |train| train.type == 'passenger'}

    puts "Number of passenger trains: #{pass_trains.length}"
    pass_trains.each { |train| puts "#{train.number}" }

    puts "Number of freight trains: #{freight_trains.length}"
    freight_trains.each { |train| puts "#{train.number}" }
  end
end
