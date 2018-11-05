class Wagon
  include Manufacturer
  include Validator

  WAGON_NUMBER_FORMAT = /^[\da-z]{3}\-?[\da-z]{2}$/i
  WAGON_TYPE_FORMAT   = /^(cargo|passenger)$/i

  attr_reader :number, :type

  def initialize(number, type)
    @number = number
    @type = type
    validate!
  end

  def info
    "#{@number} - #{@type}"
  end

  protected

  def validate!
    raise "Number cannot be nil" if number.nil?
    raise "Number is too short" if number.length < 4
    raise "Number has an invalid format" if number !~ WAGON_NUMBER_FORMAT
    raise "Type can only be 'cargo' or 'passenger'" if type !~ WAGON_TYPE_FORMAT
  end
end
