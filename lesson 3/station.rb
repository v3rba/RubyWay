class Station
  attr_accessor :name, :trains
  
  def initialize name
    @name = name
    @trains = []
  end

  def train_get train
    @trains << train
  end

  def train_send train
    trains.delete(train)
  end

  def train_list
    @trains
  end

  def train_list_by_type
    @trains
  end

end
