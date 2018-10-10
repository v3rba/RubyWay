require './manufacturer'
require './validation_error'

class Train
  include Manufacturer
  include Instances
  attr_reader :number, :type, :route, :carriages, :speed

  NUMBER_PATTERN = /^[a-z\d]{3}-?[a-z\d]{2}$/i
  TYPE_PATTERN = /^[a-z]{3,}$/i

  def initialize(number, type, carriages)
    @number = number
    @type = type
    @carriages = carriages
    @speed = initial_speed
    validate!
    add(self)
  end

  def gain_speed
    self.speed += gain_speed_difference
  end

  def stop
    self.speed = stop_speed
  end

  def add_carriage(carriage)
    carriages << carriage if stopped? && correct_carriage?(carriage)
  end

  def delete_carriage(carriage = carriages.last)
    carriages.delete(carriage) if stopped?
  end

  def each_carriage
    block_given? ? carriages.each_with_index { |carriage, index| yield(carriage, index) } : carriages
  end

  def route=(route)
    @route = route
    self.current_station_id = start_station_id
  end

  def go
    route.stations.each { |_station| go_to_the_next_station } if at_start?
  end

  def go_back
    route.stations.each { |_station| go_to_the_next_station }
  end

  def go_to_the_next_station
    go_to_the_next_station! if next?
  end

  def current_station
    route.stations[current_station_id] if route
  end

  def next_station
    route.stations[current_station_id + 1] if next?
  end

  def previous_station
    route.stations[current_station_id - 1] if previous?
  end

  def stopped?
    speed.zero?
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  protected

  attr_accessor :current_station_id
  attr_writer :speed

  def go_to_the_next_station!
    gain_speed
    current_station.send_out(self) if current_station
    self.current_station_id += 1
    current_station.take(self) if current_station
    stop
  end

  def go_to_the_last_station!
    gain_speed
    current_station.take(self) if current_station
    self.current_station_id -= 1
    current_station.take(self) if current_station
    stop
  end

  def validate!
    raise ValidationError, 'Wrong number' if number !~ NUMBER_PATTERN
    raise ValidationError, 'Type must contains 3 letters a-z or more' if type !~ TYPE_PATTERN

    true
  end

  def at_start?
    current_station_id.zero?
  end

  def next?
    current_station_id < route.stations.size - 1
  end

  def previous?
    current_station_id > 0
  end

  def correct_carriage?(carriage)
    carriage_type =
      case type
      when 'cargo'
        CargoCarriage
      when 'passenger'
        PassengerCarriage
      else
        Carriage
      end
    carriage.class == carriage_type
  end

  def initial_speed
    0
  end

  def stop_speed
    0
  end

  def gain_speed_difference
    10
  end

  def start_station_id
    0
  end
end
