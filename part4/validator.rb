module Validator
  NUMBER_FORMAT = /^[\da-z]{3}\-?[\da-z]{2}$/i
  TYPE_FORMAT   = /^(cargo|passenger)$/i
  NAME_FORMAT   = /^[a-z][a-z\-? ?]*[a-z]$/i

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    case self
    when Train, Wagon
      raise "Number cannot be nil" if number.nil?
      raise "Number is too short" if number.length < 4
      raise "Number has an invalid format" if number !~ NUMBER_FORMAT
      raise "Type can only be 'cargo' or 'passenger'" if type !~ TYPE_FORMAT
    when Station
      raise "Name cannot be blank" if name.empty?
      raise "Name is too short" if name.length < 3
      raise "Name is invalid" if name !~ NAME_FORMAT
    when Route
      raise "Station/s is invalid" unless stations.all?{ |station| station.instance_of?(Station) }
      raise "Start and last station cannot be the same" if stations.first.name == stations.last.name
    end
  end
end
