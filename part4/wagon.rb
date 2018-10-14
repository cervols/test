class Wagon
  include Manufacturer
  include Validator

  attr_reader :number, :type

  def initialize(number, type)
    @number = number
    @type = type
    validate!
  end

  def info
    "#{@number} - #{@type}"
  end
end
