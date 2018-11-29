class PassengerWagon < Wagon
  MAX_PLACE_AMOUNT = 250

  strong_attr_accessor :category, String

  def initialize(number, seats)
    super(number, seats, 'passenger')
  end

  def reserve_place
    super(1)
  end
end
