class Interface
  def welcome
    cls
    puts 'Welcome to the Railway program!'
    separator
  end

  def goodbye
    puts 'Goodbye!'
  end

  def pause
    puts 'Press Enter to continue...'
    gets.chomp
  end

  def show_collection_info(collection)
    collection.each { |object| puts object.info }
    pause
  end

  def show_train_info(train)
    puts "Number: #{train.number}; type: #{train.type}; wagons number: #{train.wagons_number}"
  end

  def show_wagon_info(wagon, place_type)
    puts "Number: #{wagon.number}; " \
      "type: #{wagon.type}; " \
      "available #{place_type}: #{wagon.available_place}; " \
      "occupied #{place_type}: #{wagon.occupied_place}"
  end

  def show_main_menu
    puts 'What do you want to do? Please, enter your choice and press Enter:'
    puts '1 - create station, train, wagon or route'
    puts '2 - work with created objects at Railway'
    puts '3 - info about objects'
    puts '0 - quit the program'
    separator
  end

  def show_create_menu
    cls
    puts 'What do you want to create?'
    puts '1 - create station'
    puts '2 - create train'
    puts '3 - create wagon'
    puts '4 - create route'
    puts '0 - return to the previous menu'
    separator
  end

  def show_work_menu
    cls
    puts 'What do you want to do?'
    puts '1 - add station to route'
    puts '2 - delete station from route'
    puts '3 - add route to train'
    puts '4 - add wagon to train'
    puts '5 - remove wagon from train'
    puts '6 - reserve seat/volume in the wagon'
    puts '7 - send train to next station'
    puts '8 - send train to previous station'
    puts '0 - return to the previous menu'
    separator
  end

  def show_info_menu
    cls
    puts 'What type of objects are you interested in?'
    puts '1 - stations'
    puts '2 - trains'
    puts '3 - trains on station'
    puts '4 - wagons'
    puts '5 - wagons in train'
    puts '6 - routes'
    puts '0 - return to the previous menu'
    separator
  end

  def user_answer
    gets.chomp
  end

  def dont_understand(choice)
    puts "You gave me '#{choice}' - I have no idea what to do with that."
    pause
  end

  def success(*args)
    puts 'Operation completed successfully'
    puts "#{args.first} #{args.last} was created." unless args.empty?
    pause
  end

  def exception_message(error)
    puts error.message
  end

  def ask_about_retry
    puts "Press Enter to try again or enter '0' to return to menu"
  end

  def error_not_found(object_type, id = '')
    puts "#{object_type} #{id} not found"
    pause
  end

  def error_no_objects(object_type)
    puts "There are no #{object_type} yet"
    pause
  end

  def error_no_trains_on_station(station_name)
    puts "There are no trains at station #{station_name}"
    pause
  end

  def error_no_wagons_in_train(train_number)
    puts "There are no wagons in train #{train_number}"
    pause
  end

  def ask_enter_station(type = '', additional = '')
    puts "Please, enter the#{type} station name#{additional}:"
  end

  def ask_enter_train_type
    puts 'What type of train do you want to create?'
    puts '1 - passenger'
    puts '2 - cargo'
  end

  def ask_enter_train_number
    puts 'Please, enter the train number:'
  end

  def ask_enter_wagon_type
    puts 'What type of wagon do you want to create?'
    puts '1 - passenger'
    puts '2 - cargo'
  end

  def ask_enter_wagon_number
    puts 'Please, enter the wagon number:'
  end

  def ask_enter_seats_number
    puts 'Please, enter the seats number in the wagon:'
  end

  def ask_enter_volume
    puts 'Please, enter the volume of the wagon:'
  end

  def ask_about_seat_reservation(wagon_number)
    puts "Enter '1' and press Enter to confirm the seat reservation in the wagon #{wagon_number}"
  end

  def ask_about_volume_reservation(wagon_number)
    puts "Please, enter the volume to reserve it in the wagon #{wagon_number}"
  end

  def ask_additional_question(text)
    print text
  end

  private

  def cls
    system('reset')
  end

  def separator
    puts '=' * 20
  end
end
