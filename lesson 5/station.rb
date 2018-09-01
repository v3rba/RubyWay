require "./instances"

class Station
  include Instances
  attr_reader :name, :trains

  def initialize name
    @name = name
    @trains = []
  end

  def get_train train
    @trains << train
  end

  def delete_train train 
    @trains.delete(train)
  end

  def all_trains
    @trains.each { |train| puts "#{train}" }
  end

  def show_trains type
    trains.select { |train| train.type == type }
  end
end