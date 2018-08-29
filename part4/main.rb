require_relative 'railway'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'route'
require_relative 'station'

def cls
  system('reset')
end

def pause
  gets.chomp
end

def separator
  puts '=' * 20
end

rw = RailWay.new

puts "Welcome to the Railway program!"
separator

loop do
  puts 'What do you want to do? Please, enter your choice and press Enter:'
  puts '1 - create station, train, wagon or route'
  puts '2 - work with created objects at Railway'
  puts '3 - info about objects'
  puts '0 - quit the program'
  separator

  choise = gets.chomp

  break if choise == '0'

  case choise
  when '1'
    loop do
      cls
      puts 'What do you want to create?'
      puts '1 - create station'
      puts '2 - create train'
      puts '3 - create wagon'
      puts '4 - create route'
      puts '0 - return to the previous menu'
      separator

      choise = gets.chomp

      break if choise == '0'

      case choise
      when '1'
        puts 'Please, enter the station name:'
        station = Station.new(gets.chomp)
        if station
          rw.stations << station
          puts "The '#{station.name}' station was created"
        else
          puts 'Something went wrong...'
        end
        pause

      when '2'
        puts 'What type of train do you want to create?'
        puts '1 - passenger'
        puts '2 - cargo'
        train_type = gets.chomp
        puts 'Please, enter the train number:'
        train_number = gets.chomp
        
        if train_type == "1"
          train = PassengerTrain.new(train_number)
          rw.trains << train
          puts "The #{train.number} passenger train was created"
        elsif train_type == "2"
          train = CargoTrain.new(train_number)
          rw.trains << train
          puts "The #{train.number} cargo train was created"
        else
          puts 'Sorry, I did not understand you'
        end
        pause

      when '3'
        puts 'What type of wagon do you want to create?'
        puts '1 - passenger'
        puts '2 - cargo'
        wagon_type = gets.chomp
        puts 'Please, enter the wagon number:'
        wagon_number = gets.chomp

        if wagon_type == "1"
          wagon = PassengerWagon.new(wagon_number)
          rw.wagons << wagon
          puts "The passenger wagon was created"
        elsif wagon_type == "2"
          wagon = CargoWagon.new(wagon_number)
          rw.wagons << wagon
          puts "The cargo wagon was created"
        else
          puts 'Sorry, I did not understand you'
        end
        pause

      when '4'
        puts 'Please, enter the start station name:'
        start_station_name = gets.chomp
        start_station = rw.find_station(start_station_name)
        unless start_station
          start_station = Station.new(start_station_name)
          rw.stations << start_station
          puts "The '#{start_station.name}' station was created"
        end

        puts 'Please, enter the end station name:'
        end_station_name = gets.chomp
        end_station = rw.find_station(end_station_name)
        unless end_station
          end_station = Station.new(end_station_name)
          rw.stations << end_station
          puts "The '#{end_station.name}' station was created"
        end

        if start_station && end_station
          rw.routes << Route.new(start_station, end_station)
          puts 'New route was created'
        else
          puts 'Something went wrong...'
        end

        else
          puts "You gave me '#{choise}' - I have no idea what to do with that."
        end
        pause
      end

  when '2'
    loop do
      cls
      puts 'What do you want to do?'
      puts '1 - add station to route'
      puts '2 - delete station from route'
      puts '3 - add route to train'
      puts '4 - add wagon to train'
      puts '5 - remove wagon from train'
      puts '6 - send train to next station'
      puts '7 - send train to previous station'      
      puts '0 - return to the previous menu'
      separator

      choise = gets.chomp

      break if choise == '0'

      case choise
      when '1'
        puts 'What route do you want to update? Please, enter start station:'
        start_station_name = gets.chomp
        puts 'And now enter end station:'
        end_station_name = gets.chomp

        route = rw.find_route(start_station_name, end_station_name)

        if route
          puts "Please, enter station name for adding to route:"
          station_name = gets.chomp

          station = rw.find_station(station_name)

          if station
            route.add_station(station)
          else
            new_station = Station.new(station_name)
            rw.stations << new_station
            route.add_station(new_station)
            puts "The '#{new_station.name}' station was created"
          end
          puts "Station #{station_name} was added to route #{start_station_name}-#{end_station_name}"
        else
          puts "Route #{start_station_name}-#{end_station_name} not found"
        end
        pause

      when '2'
        puts 'What route do you want to update? Please, enter start station:'
        start_station_name = gets.chomp
        puts 'And now enter end station:'
        end_station_name = gets.chomp

        route = rw.find_route(start_station_name, end_station_name)

        if route
          puts "Please, enter station name to remove it from the route:"
          station_name = gets.chomp

          station = rw.find_station(station_name)

          if station
            route.delete_station(station)
          else
            puts "The '#{station_name}' does not exist"
          end
        else
          puts "Route #{start_station_name}-#{end_station_name} not found"
        end
        pause

      when '3'
        puts 'Please, enter train number:'
        train_number = gets.chomp

        train = rw.find_train(train_number)

        if !train
          puts "Train #{train_number} not found"
        else
          puts 'What route do you want to add to train? Please, enter start station:'
          start_station_name = gets.chomp
          puts 'And now enter end station:'
          end_station_name = gets.chomp

          route = rw.find_route(start_station_name, end_station_name)

          if route
            train.add_route(route)
            puts "Route #{start_station_name}-#{end_station_name} was added to train number '#{train_number}'"
          else
            puts "Route #{start_station_name}-#{end_station_name} not found"
          end
        end
        pause

      when '4'
        puts 'Please, enter train number:'
        train_number = gets.chomp

        train = rw.find_train(train_number)

        if train
          puts 'Which wagon do you want to add? Please, enter the wagon number:'
          wagon_number = gets.chomp

          wagon = rw.find_wagon(wagon_number)

          train.add_wagon(wagon) if wagon
        else
          puts "Train #{train_number} not found"
        end
        pause

      when '5'
        puts 'Please, enter train number:'
        train_number = gets.chomp

        train = rw.find_train(train_number)

        if train
          train.delete_wagon
          puts "Train has #{train.wagons_number} wagons now"
        else
          puts "Train #{train_number} not found"
        end
        pause

      when '6'
        puts 'Please, enter train number:'
        train_number = gets.chomp

        train = rw.find_train(train_number)

        if train
          train.go_to_next_station
        else
          puts "Train #{train_number} not found"
        end
        pause

      when '7'
        puts 'Please, enter train number:'
        train_number = gets.chomp

        train = rw.find_train(train_number)

        if train
          train.go_to_previous_station
        else
          puts "Train #{train_number} not found"
        end
        pause
      else puts "You gave me '#{choise}' - I have no idea what to do with that."
      end
    end

  when '3'
    loop do
      cls
      puts 'What type of objects are you interested in?'
      puts '1 - stations'
      puts '2 - trains'
      puts '3 - trains on station'
      puts '4 - wagons'
      puts '5 - routes'
      puts '0 - return to the previous menu'
      separator

      choise = gets.chomp

      break if choise == '0'

      case choise
      when '1'
        rw.stations.each { |station| puts station.name }
        pause

      when '2'
        rw.trains.each { |train| puts "#{train.number} - #{train.type}, number of wagons = #{train.wagons_number}" }
        pause

      when '3'
        puts 'What station are you interested in?'
        station_name = gets.chomp

        station = rw.find_station(station_name)

        if !station
          puts "Station #{station_name} does not exist"
        elsif station.trains.empty?
          puts "There are no trains at the #{station_name} station"
        else
          puts 'Trains on station:'
          station.trains.each { |train| puts "#{train.number} - #{train.type}, number of wagons = #{train.wagons_number}"}
        end
        pause

      when '4'
        rw.wagons.each { |wagon| puts "#{wagon.number} - #{wagon.type}" }
        pause

      when '5'
        rw.routes.each { |route| route.stations.each { |station| puts station.name } }
        pause
      else
        puts "You gave me '#{choise}' - I have no idea what to do with that."
        pause
      end
    end      
  else
    puts "You gave me '#{choise}' - I have no idea what to do with that."
    pause
  end
end
