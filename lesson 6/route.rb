class Route
  attr_reader :stations

  def initialize first_station, last_station
    @stations = [first_station, last_station]
  end

  def from
    stations.first
  end

  def to
    stations.last
  end

  def add_station station
    @stations.insert(-2, station)
  end

  def remove_station station
    unless [from, to].include?(station)
  end

  def show_stations
    @stations.each { |station| puts "#{station.name}" }
  end
end

end
