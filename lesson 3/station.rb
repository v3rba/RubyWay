class Station

  attr_reader :station_name

  def initialize station_name
    @station_name = station_name
    @train_list = []
  end

  def arrival_train train
    @train_list << train
    puts "На станцию #{name} прибыл поезд №#{train.number}"
  end

  def display_train_list
    @train_list.each { |train| puts "Поезд №#{train.number}, #{train.type}, #{train.wagons}" }
  end

  def train_list_type type
    @train_list.each { |train| train_type_counter +=1 if train.type.include?(self) }
  end

  def departure_train train
    @train_list.delete(train)
  end

end
