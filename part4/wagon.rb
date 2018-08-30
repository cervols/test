class Wagon
  attr_reader :number , :type

  def initialize(number, type = 'wagon')
    @number = number
    @type = type
  end
end
