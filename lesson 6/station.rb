require "./validation_error"

class Station
  attr_reader :name, :trains

  NAME_PATTERN = /^[a-z]{3}$/i

  def initialize name
    @name = name
    @trains = []
    validate!
    add(self)
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

  def valid?
    validate!
  rescue 
    false
  end

  protected

  def validate!
    raise ValidationError, "Name must contains 3 letters a-z or more" if name !~ NAME_PATTERN
    true
  end
end
