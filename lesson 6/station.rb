require_relative 'instancecounter'

class Station
  include InstanceCounter
  attr_reader :station_name 

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(station_name)
    register_instance
    @station_name = station_name
    @train_list = []
    validate!
    @@stations << self
  end

  def valid?
    validate!
  rescue
    false
  end  

  def arrival_train(train)
    @train_list << train
  end

  def show_train_list
    @train_list.each { |train| puts "Поезд №#{train.number} | Тип #{train.type} | Количество вагонов #{train.carriages.length}" }
  end

  def train_list_type(type)
    train_type_counter = 0
    @train_list.each { |train| train_type_counter +=1 if train.type.eql?(type) }

    puts "Количество поездов на станций #{@station_name} типа #{type} равно #{train_type_counter} "
  end

  def departure_train(train)
    @train_list.delete(train)
  end

  protected

  def validate!
    raise "Название станций не может быть nil" if station_name.nil?
    raise "Название станций дожно быть меньше 50 символов" if station_name.length > 50
    true
  end
end
