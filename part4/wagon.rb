class Wagon
  include Manufacturer
  include Validation
  include Accessors

  WAGON_NUMBER_FORMAT = /^[\da-z]{3}\-?[\da-z]{2}$/i
  WAGON_TYPE_FORMAT   = /^(cargo|passenger)$/i

  attr_reader :number, :type, :occupied_place
  attr_accessor_with_history :color

  validate :number, :presence
  validate :number, :format, WAGON_NUMBER_FORMAT
  validate :type, :format, WAGON_TYPE_FORMAT
  validate :place, :type, Integer

  def initialize(number, place, type)
    @number = number
    @place = place
    @type = type
    @occupied_place = 0
    validate!
    validate_place_amount!
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

  def validate_place_amount!
    raise 'Invalid seats/volume amount' unless @place.between?(1, self.class::MAX_PLACE_AMOUNT)
  end
end
