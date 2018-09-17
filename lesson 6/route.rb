require_relative 'instancecounter'

class Route

  include InstanceCounter

  attr_reader :route_list

  def initialize(starting_station, ending_station)
    register_instance
    validate!
    @route_list = [starting_station, ending_station]    
  end

  def valid?
    validate!
  rescue
    false
  end

  def middle_station_add(station)
    @route_list.insert(-2, station)
  end

  def middle_station_delete(station)
    @route_list.delete(station)
  end

  protected

  def validate!
    raise "Начальная\\Конечная станция должна быть объектом класса Station" if starting_station.class && ending_station.class != Station
    true   
  end
  
end
