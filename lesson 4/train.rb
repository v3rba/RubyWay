class Train
  attr_reader :number, :type, :route, :carriages, :speed

  def initialize number, type, carriages
    @number = number
    @type = type
    @carriages = carriages
    @speed = 0
  end

  def gain_speed
    self.speed += 10
  end

  def stop
    self.speed = 0
  end

  def add_carriage
    self.carriages += 1 if is_stopped?
  end

  def delete_carriage
    self.carriages -= 1 if is_stopped?
  end

  def is_correct_carriage? carriage
    carriage_type =
      case self.type
      when "cargo"
        CargoCarriage
      when "passanger"
        PassangerCarriage
      else
        Carriage
      end
    carriage.class == carriage_type
  end

  def route=(route)
    @route = route
    self.current_station_id = 0
  end

  def current_station
    route.stations[current_station_id]
  end

  def next_station
    route.stations[current_station_id + 1] if has_next?
  end

  def previous_station
    route.stations[current_station_id - 1] if has_previous?
  end

  private 

  attr_accessor :current_station_id
  attr_writer :speed

  def go
    route.stations.each { |station| go_to_the_next_station } if at_start?
  end

  def go_to_the_next_station
    if has_next?
      gain_speed
      current_station.delete_train(self)
      self.current_station_id += 1
      current_station.get_train(self)
      stop
    end
  end

  def at_start?
    current_station_id.zero?
  end

  def has_next?
    current_station_id < route.stations.size - 1
  end

  def has_previous?
    current_station_id > 0
  end

  def is_stopped?
    speed.zero?
  end
end
