class PassengerWagon < Wagon
  attr_reader :occupied_seats

  MAX_SEATS_NUMBER = 250

  def initialize(number, seats)
    @seats = seats
    @occupied_seats = 0
    super(number, 'passenger')
  end

  def reserve_seat
    @occupied_seats += 1 if @occupied_seats < @seats
  end

  def available_seats
    @seats - @occupied_seats
  end

  private

  def validate!
    raise "Invalid seats number" unless @seats.between?(1,MAX_SEATS_NUMBER)
    super
  end
end
