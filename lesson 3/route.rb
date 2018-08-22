class Route

  attr_reader :route_list

  def initialize starting_station, ending_station
    @route_list = [starting_station, ending_station]
  end

  def middle_station_add station
    @route_list.insert(-2, station)
  end

  def middle_station_delete station
    @route_list.delete(station)
  end
end
