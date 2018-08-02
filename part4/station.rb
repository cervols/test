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
      train.station = self.name
    end
  end

  def send_train(train)
    train.station = train.go_to_next_station
    @trains.delete(train)
  end

  def show_trains
    @trains.each { |train| puts "#{train.number} - #{train.type} - " +
      "#{train.wagons_number} wagons" }
  end

  def show_type_trains
    pass_trains = []
    freight_trains = []
    @trains.each do |train|
      if train.type == 'passenger'
        pass_trains << train
      elsif train.type == 'freight'
        freight_trains << train
      end
    end
    puts "Number of passenger trains: #{pass_trains.length}"
    pass_trains.each { |train| puts "#{train.number}" }

    puts "Number of freight trains: #{freight_trains.length}"
    freight_trains.each { |train| puts "#{train.number}" }
  end
end
