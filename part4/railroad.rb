class Railroad
  attr_reader :stations, :routes, :trains, :wagons

  def initialize(interface)
    @interface = interface
    @stations = []
    @routes   = []
    @trains   = []
    @wagons   = []
  end
  
  def run
    @interface.welcome
    main_menu
  end

  private

  def user_input
    @interface.get_answer
  end

  def find_station(station_name)
    @stations.find { |station| station.name.downcase == station_name.downcase }
  end

  def find_route
    @interface.ask_enter_station(' start')
    start_station_name = user_input

    @interface.ask_enter_station(' end')
    end_station_name = user_input

    @routes.find { |route| route.first.name.downcase == start_station_name.downcase &&
      route.last.name.downcase == end_station_name.downcase }
  end

  def find_train(train_number)
    @trains.find { |train| train.number.downcase == train_number.downcase }
  end

  def find_wagon(wagon_number)
    @wagons.find { |wagon| wagon.number.downcase == wagon_number.downcase }
  end

  def main_menu
    @interface.show_main_menu
    choice = user_input
    case choice
    when '0'
      @interface.goodbye
      exit
    when '1'
      create_menu
    when '2'
      work_menu
    when '3'
      info_menu
    else
      @interface.dont_understand(choice)
      main_menu
    end
  end

  def create_menu
    loop do
      @interface.show_create_menu
      choice = user_input
      case choice
      when '0'
        main_menu
      when '1'
        create_station
      when '2'
        create_train
      when '3'
        create_wagon
      when '4'
        create_route
      else
        @interface.dont_understand(choice)
      end
    end
  end

  def work_menu
    loop do
      @interface.show_work_menu
      choice = user_input
      case choice
      when '0'
        main_menu
      when '1'
        add_station_to_route
      when '2'
        remove_station_from_route
      when '3'
        add_route_to_train
      when '4'
        change_wagons_number('add to train')
      when '5'
        change_wagons_number('remove from train')
      when '6'
        send_train('forward')
      when '7'
        send_train('back')
      else
        @interface.dont_understand(choice)
      end
    end
  end

  def info_menu
    loop do
      @interface.show_info_menu
      choice = user_input
      case choice
      when '0'
        main_menu
      when '1'
        stations_info
      when '2'
        trains_info
      when '3'
        trains_on_station_info
      when '4'
        wagons_info
      when '5'
        routes_info
      else
        @interface.dont_understand(choice)
      end
    end
  end

  def create_station
    @interface.ask_enter_station
    station = Station.new(user_input)
    if station
      @stations << station
      @interface.success
    else
      @interface.error
    end
  end

  def create_train
    @interface.ask_enter_train_type
    train_type = user_input
    @interface.ask_enter_train_number
    train_number = user_input
    if train_type == "1"
      train = PassengerTrain.new(train_number)
      @trains << train
      @interface.success
    elsif train_type == "2"
      train = CargoTrain.new(train_number)
      @trains << train
      @interface.success
    else
      @interface.error
    end
  end

  def create_wagon
    @interface.ask_enter_wagon_type
    wagon_type = user_input
    @interface.ask_enter_wagon_number
    wagon_number = user_input
    if wagon_type == "1"
      wagon = PassengerWagon.new(wagon_number)
      @wagons << wagon
      @interface.success
    elsif wagon_type == "2"
      wagon = CargoWagon.new(wagon_number)
      @wagons << wagon
      @interface.success
    else
      @interface.error
    end
  end

  def create_route
    @interface.ask_enter_station(' start')
    start_station_name = user_input
    start_station = find_station(start_station_name)
    unless start_station
      start_station = Station.new(start_station_name)
      @stations << start_station
    end
    @interface.ask_enter_station(' end')
    end_station_name = user_input
    end_station = find_station(end_station_name)
    unless end_station
      end_station = Station.new(end_station_name)
      @stations << end_station
    end
    if start_station && end_station
      @routes << Route.new(start_station, end_station)
      @interface.success
    else
      @interface.error
    end
  end

  def add_station_to_route
    @interface.ask_additional_question('What route do you want to update? ')
    route = find_route
    unless route
      @interface.error_not_found('Route')
      return
    end

    @interface.ask_enter_station('',' for adding to route')
    station_name = user_input
    station = find_station(station_name)
    if station
      route.add_station(station)
    else
      new_station = Station.new(station_name)
      stations << new_station
      route.add_station(new_station)
    end
    @interface.success
  end

  def remove_station_from_route
    @interface.ask_additional_question('What route do you want to update? ')
    route = find_route
    unless route
      @interface.error_not_found('Route')
      return
    end

    @interface.ask_enter_station('',' to remove it from the route')
    station_name = user_input
    station = find_station(station_name)
    if station
      route.delete_station(station)
      @interface.success
    else
      @interface.error_not_found('Station', station_name)
    end
  end

  def add_route_to_train
    @interface.ask_enter_train_number
    train_number = user_input

    train = find_train(train_number)
    if !train
      @interface.error_not_found('Train', train_number)
      return
    end

    @interface.ask_additional_question('What route do you want to add to train? ')
    route = find_route
    unless route
      @interface.error_not_found('Route')
      return
    end

    train.add_route(route)
    @interface.success
  end

  def change_wagons_number(action)
    @interface.ask_enter_train_number
    train_number = user_input
    train = find_train(train_number)
    unless train
      @interface.error_not_found('Train', train_number)
      return
    end
    @interface.ask_enter_wagon_number
    wagon_number = user_input
    wagon = find_wagon(wagon_number)
    unless wagon
      @interface.error_not_found('Wagon', wagon_number)
      return
    end
    if action == 'remove from train'
      train.delete_wagon(wagon)
    elsif action == 'add to train'
      train.add_wagon(wagon) unless train.wagons.include?(wagon)
    end    
    @interface.pause
  end

  def send_train(direction)
    @interface.ask_enter_train_number
    train_number = user_input
    train = find_train(train_number)
    unless train
      @interface.error_not_found('Train', train_number)
      return
    end
    if direction == 'forward'
      train.go_to_next_station
    elsif direction == 'back'
      train.go_to_previous_station
    end
    @interface.pause
  end

  def stations_info
    if @stations.empty?
      @interface.error_no_objects('stations')
    else
      @interface.show_collection_info(@stations)
    end
  end

  def trains_info
    if @trains.empty?
      @interface.error_no_objects('trains')
    else
      @interface.show_collection_info(@trains)
    end
  end

  def trains_on_station_info
    @interface.ask_enter_station
    station_name = user_input
    station = find_station(station_name)
    if !station
      @interface.error_not_found('Station', station_name)
    elsif station.trains.empty?
      @interface.error_no_trains_on_station(station_name)
    else
      station.trains.each { |train| train.info }
      @interface.pause
    end
  end

  def wagons_info
    if @wagons.empty?
      @interface.error_no_objects('wagons')
    else
      @interface.show_collection_info(@wagons)
    end
  end

  def routes_info
    if @routes.empty?
      @interface.error_no_objects('routes')
    else
      @routes.each { |route| @interface.show_collection_info(route.stations) }
    end
  end
end
