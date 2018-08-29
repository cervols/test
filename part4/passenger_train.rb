class PassengerTrain < Train
  def initialize(number)
    super
    @type = 'passenger'
  end
  
  def add_wagon(wagon)
    if wagon.type == @type
      super
    else
      puts "Error! You can add only #{@type} wagon to this train"
    end
  end
end
