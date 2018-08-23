class Route

  attr_reader :stations, :first_station, :last_station

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
    @stations.delete(station) if station != from && station != to
  end

  def show_stations
    @stations.each { |station| puts "#{station.name}" }
  end

end
