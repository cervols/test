class Wagon
  include Manufacturer

  attr_reader :number, :type

  def initialize(number, type)
    @number = number
    @type = type
  end

  def info
    "#{@number} - #{@type}"
  end
end
