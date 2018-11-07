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
    @stations.find { |station| station.name.casecmp(station_name).zero? }
  end

  def find_route
    @interface.ask_enter_station(' start')
    start_station_name = user_input

    @interface.ask_enter_station(' end')
    end_station_name = user_input

    @routes.find do |route|
      route.first_station.name.casecmp(start_station_name).zero? &&
        route.last_station.name.casecmp(end_station_name).zero?
    end
  end

  def find_train(train_number)
    @trains.find { |train| train.number.casecmp(train_number).zero? }
  end

  def find_wagon(wagon_number)
    @wagons.find { |wagon| wagon.number.casecmp(wagon_number).zero? }
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
        reserve_place_in_wagon
      when '7'
        send_train('forward')
      when '8'
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
        wagons_in_train_info
      when '6'
        routes_info
      else
        @interface.dont_understand(choice)
      end
    end
  end

  def try_again?
    @interface.ask_about_retry
    user_input != '0'
  end

  def create_station
    @interface.ask_enter_station
    station = Station.new(user_input)
    @stations << station
    @interface.success(station.name, 'station')
  rescue RuntimeError => e
    @interface.error(e)
    retry if try_again?
  end

  def create_train
    @interface.ask_enter_train_type
    train_type = user_input
    unless ['1', '2'].include?(train_type)
      @interface.dont_understand(train_type)
      return
    end
    @interface.ask_enter_train_number
    train_number = user_input
    if train_type == '1'
      train = PassengerTrain.new(train_number)
      @trains << train
    elsif train_type == '2'
      train = CargoTrain.new(train_number)
      @trains << train
    end
    @interface.success('Train', train_number)
  rescue RuntimeError => e
    @interface.error(e)
    retry if try_again?
  end

  def create_wagon
    @interface.ask_enter_wagon_type
    wagon_type = user_input
    unless ['1', '2'].include?(wagon_type)
      @interface.dont_understand(wagon_type)
      return
    end
    @interface.ask_enter_wagon_number
    wagon_number = user_input
    if wagon_type == '1'
      @interface.ask_enter_seats_number
      wagon = PassengerWagon.new(wagon_number, user_input.to_i)
      @wagons << wagon
    else
      @interface.ask_enter_volume
      wagon = CargoWagon.new(wagon_number, user_input.to_f)
      @wagons << wagon
    end
    @interface.success('Wagon', wagon_number)
  rescue RuntimeError => e
    @interface.error(e)
    retry if try_again?
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
    @routes << Route.new(start_station, end_station)
    @interface.success
  rescue RuntimeError => e
    @interface.error(e)
    retry if try_again?
  end

  def add_station_to_route
    @interface.ask_additional_question('What route do you want to update? ')
    route = find_route
    unless route
      @interface.error_not_found('Route')
      return
    end

    @interface.ask_enter_station('', ' for adding to route')
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

    @interface.ask_enter_station('', ' to remove it from the route')
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
    unless train
      @interface.error_not_found('Train', train_number)
      return
    end

    @interface.ask_additional_question('What route do you want to add? ')
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

  def reserve_place_in_wagon
    @interface.ask_enter_wagon_number
    wagon_number = user_input
    wagon = find_wagon(wagon_number)
    unless wagon
      @interface.error_not_found('Wagon', wagon_number)
      return
    end
    if wagon.is_a?(PassengerWagon)
      @interface.ask_about_seat_reservation(wagon.number)
      wagon.reserve_place if user_input == '1'
    else
      @interface.ask_about_volume_reservation(wagon.number)
      amount = user_input.to_f
      wagon.reserve_place(amount)
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
      station.all_trains { |train| @interface.show_train_info(train) }
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

  def wagons_in_train_info
    @interface.ask_enter_train_number
    train_number = user_input
    train = find_train(train_number)
    if !train
      @interface.error_not_found('Train', train_number)
    elsif train.wagons.empty?
      @interface.error_no_wagons_in_train(train_number)
    else
      train.all_wagons do |wagon|
        wagon.is_a?(PassengerWagon) ? @interface.show_wagon_info(wagon, 'seats') : @interface.show_wagon_info(wagon, 'volume')
      end
      @interface.pause
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
