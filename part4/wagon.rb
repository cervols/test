class Wagon
  include Manufacturer
  include Validator

  WAGON_NUMBER_FORMAT = /^[\da-z]{3}\-?[\da-z]{2}$/i
  WAGON_TYPE_FORMAT   = /^(cargo|passenger)$/i

  attr_reader :number, :type, :occupied_place

  def initialize(number, place, type)
    @number = number
    @place = place
    @type = type
    @occupied_place = 0
    validate!
  end

  def reserve_place(amount)
    @occupied_place += amount unless @occupied_place + amount > @place
  end

  def available_place
    @place - @occupied_place
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
    raise "Invalid seats/volume amount" unless @place.between?(1,self.class::MAX_PLACE_AMOUNT)
  end
end
