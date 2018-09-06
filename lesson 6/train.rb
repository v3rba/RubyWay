require "./manufacturer"

class Train
  include Manufacturer
  attr_reader :number, :type, :route, :carriages, :speed

  NUMBER_PATTERN = /^[a-z\d]{3}-?[a-z\d]{2}$/i
  TYPE_PATTERN = /^[a-z]{3,}$/i

  def initialize number, type, carriages
    @number = number
    @type = type
    @carriages = carriages
    @speed = 0
    validate!
    add(self)
  end

  def gain_speed
    self.speed += 10
  end

  def stop
    self.speed = 0
  end

  def add_carriage carriage
    self.carriages << carriage if is_stopped? && is_correct_carriage?(carriage)
  end

  def delete_carriage carriage = self.carriages.last
    self.carriages.delete(carriage) if is_stopped?
  end

  def is_correct_carriage? carriage
    carriage_type =
      case self.type
      when "cargo"
        CarCargo
      when "passanger"
        CarPassanger
      end
    carriage.class == carriage_type
  end

  def route=(route)
    @route = route
    self.current_station_id = 0
  end

  def current_station
    route.stations[current_station_id] if route
  end

  def next_station
    route.stations[current_station_id + 1] if has_next?
  end

  def previous_station
    route.stations[current_station_id - 1] if has_previous?
  end

  def go
    route.stations.each { |station| go_to_the_next_station } if at_start?
  end

  protected 

  attr_accessor :current_station_id
  attr_writer :speed

  def go_to_the_next_station
    if has_next?
      gain_speed
      current_station.delete_train(self) if current_station
      self.current_station_id += 1
      current_station.get_train(self) if current_station
      stop
    end
  end

  def validate!
    raise ValidationError, "Wrong number" if number !~ NUMBER_PATTERN
    raise ValidationError, "Type must contains 3 letters a-z or more" if type !~ TYPE_PATTERN
    true
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
