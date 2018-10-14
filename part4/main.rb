require_relative 'railroad'
require_relative 'interface'
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validator'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'route'
require_relative 'station'

interface = Interface.new
railroad = Railroad.new(interface)
railroad.run
