class PassengerWagon < Wagon
  MAX_PLACE_AMOUNT = 250

  def initialize(number, seats)
    super(number, seats, 'passenger')
  end

  def reserve_place
    super(1)
  end
end
