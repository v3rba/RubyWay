class Train
  attr_accessor :speed, :current_station_id
  attr_reader :route

  def initialize (train_number, train_type, train_carriage_count)
    @train_number = train_number
    @train_type = train_type
    @train_carriage_count = train_carriage_count
    @speed = 0
  end

  def train_gain_speed
    @speed += 100
  end

  def train_current_speed
    @speed
  end

  def train_stop
    @speed = 0
  end

  def train_carriage_count
    @train_carriage_count
  end

  def train_add_carriage
    if train_stopped?
      @train_carriage_count += 1
    else
      puts "Error. To attach the car please stop the train."
    end
  end

  def train_remove_carriage
    if train_stopped? 
      @train_carriage_count -= 1
    else
     puts "Error. To remove the car please stop the train."
    end
  end

  def train_take_route route
    @route = route
    self.current_station_id = 0
  end

  def train_current_station
    route.stations[current_station_id]
  end

  def train_next_station
    route.stations[current_station_id + 1] if has_next?
  end

  def train_previous_station
    route.stations[current_station_id - 1] if has_previous?
  end

  def train_go_next_station
    if has_next?
      train_gain_speed
      train_current_station.train_send(self)
      self.current_station_id += 1
      train_current_station.train_get(self)
      train_stop
    end
  end

  def train_go_back_station
    if has_previous?
      train_gain_speed
      train_current_station.train_send(self)
      self.current_station_id -= 1
      train_current_station.train_get(self)
      train_stop
    end
  end

  def train_stopped?
    speed.zero?
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

end
