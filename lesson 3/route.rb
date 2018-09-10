class Route

  attr_accessor :stations

  def initialize (first_station, last_station)
    @stations = [first_station, last_station]
  end

  def station_add name
    @stations.insert(-2, name)
  end

  def station_remove name
    @stations.delete(name)
  end

  def stations_list
    @stations
  end
  
end
