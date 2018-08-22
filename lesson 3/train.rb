class Train

  attr_accessor :speed, :route
  attr_reader :number, :type, :carriages, :current_station, :current_station_id

  def initialize number, type, carriages
    @number = number
    @type = type
    @carriages = carriages

    @speed = 0
    @current_station_id = 0 
  end

  def increase_speed speed
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def add_carriages
    @carriages += 1 if self.speed == 0  
  end

  def remove_carriages
    @carriages -= 1 if self.speed == 0 
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

end
