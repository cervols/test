class Wagon
  attr_reader :number , :type

  def initialize(number, type = 'wagon')
    @number = number
    @type = type
  end

  def info
    puts "#{@number} - #{@type}"
  end
end
