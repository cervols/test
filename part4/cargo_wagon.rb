class CargoWagon < Wagon
  attr_reader :occupied_volume

  MAX_VOLUME_AMOUNT = 25000

  def initialize(number, volume)
    @volume = volume
    @occupied_volume = 0
    super(number, 'cargo')
  end

  def reserve_volume(amount)
    @occupied_volume += amount unless @occupied_volume + amount > @volume
  end

  def available_volume
    @volume - @occupied_volume
  end

  private

  def validate!
    raise "Invalid volume amount" unless @volume.between?(1,MAX_VOLUME_AMOUNT)
    super
  end
end
