class Interface
  def welcome
    cls
    puts "Welcome to the Railway program!"
    separator
  end

  def goodbye
    puts "Goodbye!"
  end

  def pause
    puts 'Press Enter to continue...'
    gets.chomp
  end

  def show_collection_info(collection)
    collection.each { |object| puts object.info }
    pause
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
    puts '6 - send train to next station'
    puts '7 - send train to previous station'
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
    puts '5 - routes'
    puts '0 - return to the previous menu'
    separator
  end

  def get_answer
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

  def error(e)
    puts e.message
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
