require_relative 'companymanagment'
require_relative 'instancecounter'

class Train

  include CompanyManagment
  include InstanceCounter

  attr_accessor :route 
  attr_reader :number, :speed, :carriages, :current_station, :current_station_id

  NUMBER_FORMAT = /^([а-я]{3}|\d{3})(-|)([а-я]{2}|\d{2})$/i

  @@trains = {}

  def self.find(train_number)
    @@trains[train_number]
  end

  def initialize(number)
    register_instance
    @number = number
    @carriages = []
    @speed = 0
    @current_station_id = 0
    validate!
    @@trains[@number] = self
  end

  def valid?
    validate!
  rescue
    false
  end

  def add_carriages(carriage)
    @carriages << carriage if train_stopped?
  end

  def remove_carriages(carriage)
    @carriages.delete(carriage) if train_stopped?
  end

  def type
    self.class
  end

  def increase_speed(speed)
    self.speed += speed
  end

  def train_stopped?
    self.speed.zero?
  end

  def stop 
    self.speed = 0
  end

  def show_route_list
    route.route_list
  end

  def set_starting_station 
    @current_station = route.route_list[0]
  end 

  def go_forward 
    if route.route_list.last != current_station && current_station_id <= route.route_list.length
      @current_station_id += 1
      @current_station = route.route_list[current_station_id]
    end
  end

  def go_backward 
    if route.route_list[0] != current_station && current_station_id > 0
      @current_station_id -= 1
      @current_station = route.route_list[current_station_id]
    end
  end
    
  def show_next_station
    puts "Следующая станция #{route.route_list[@current_station_id + 1].station_name}"
  end

  def show_prev_station 
    puts "Предыдущая станция #{route.route_list[@current_station_id - 1].station_name}"
  end

protected

  attr_writer :speed # Скорость инициализируется при созданий объекта, изменение переменной speed происходит через метод increase_speed

  def validate!
    raise "Номер не может быть nil" if number.nil?
    raise "Номер должен быть меньше 6 символов" if number.length > 6
    raise "Номер имеет не верный формат" if number !~ NUMBER_FORMAT
    true
  end

end
