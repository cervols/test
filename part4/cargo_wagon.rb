class CargoWagon < Wagon
  MAX_PLACE_AMOUNT = 25000

  def initialize(number, volume)
    super(number, volume, 'cargo')
  end
end
