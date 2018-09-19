require "./station"
require "./train"
require "./cargo_train"
require "./passenger_train"
require "./carriage"
require "./cargo_carriage"
require "./passenger_carriage"
require "./route"
require "./validation_error"

class Interface
  attr_reader :trains

  def initialize
    @route_collection = []
  end

  def start
    loop do
      help

      case gets.chomp
      when "exit"
        break
      when "create_station"
        create_station
      when "create_train"
        create_train
      when "create_route"
        make_route
      when "route_for_train"
        route_for_train
      when "add_carriage"
        add_carriage
      when "delete_carriage"
        delete_carriage
      when "move_train"
        move_train
      when "display_stations"
        display_stations
      else
        unknown_command
      end
    end
  end

  private # TrainConsole hasn't subclasses, helper methods

  def help
    puts ""
    puts 'Input "exit" for exit'
    puts 'Input "create_station" for create a station'
    puts 'Input "create_route" to create a new route'
    puts 'Input "route_for_train" for putting train on route'
    puts 'Input "create_train for create a train'
    puts 'Input "add_carriage" for add a carriage'
    puts 'Input "delete_carriage" for delete a carriage'
    puts 'Input "move_train" for move a train'
    puts 'Input "display_stations" to show trains in station'
    puts ""
  end

  def create_station
    name = station_input
    Station.new(name)
    puts "Station with name: #{name} has been created."
  rescue ValidationError => e
    puts e.message
    retry
  end

  def enter_stations_route
    puts 'Введите станцию отправления'
    @first_station = gets.chomp
    puts 'Введите конечную станцию'
    @last_station = gets.chomp
  end

  def make_route
    begin
      puts '***** Making new route *****'
      enter_stations_route
      create_route(@first_station, @last_station)
      puts "#{@first_station} #{@last_station}"
    rescue RuntimeError => e
      сaught_error(e)
    end
  end

  def create_route(first_station, last_station)
    @route_collection << Route.new(first_station, last_station)
  end

  def route_guidance(number_train, first_station, last_station)
    train = get_train(number_train)
    route = get_route(first_station, last_station)
    train.route_station(route) if train && route
  end

  def route_for_train
    begin
      enter_number_train
      enter_stations_route
      route_guidance(@number_train, @first_station, @last_station)
    rescue RuntimeError => e
      сaught_error(e)
    end
  end

  def enter_number_train
    puts 'Enter train number'
    @number_train = gets.chomp
  end

  def create_train
    number, type, carriages_count = train_input
    create_train!(number, type, carriages_count)
  rescue ValidationError => e
    puts e.message
    retry
  end

  def add_carriage
    index = choose_train

    if check_train_index?(index)
      puts "Wrong index"
    else
      train = Train.find(index)
      carriage = get_carriage(train.type)

      train.add_carriage(carriage)
      puts "Carriage has been added"
    end
  end

  def delete_carriage
    index = choose_train

    if check_train_index?(index)
      puts "Wrong index"
    else
      Train.find(index).delete_carriage
      puts "Carriage has been deleted"
    end
  end

  def move_train
    train_index = choose_train

    if check_train_index?(train_index)
      puts "Wrong index"
    else
      station_index = choose_station
      move_train!(train_index, station_index) unless check_station_index?(station_index)
    end
  end

  def display_stations
    index = choose_station
    station = Station.find(index)
    puts "Station #{index}, Trains:"
    puts station.trains unless station.nil?
  end

  def unknown_command
    puts "I don't know this command: #{input}"
  end

  def choose_station
    stations = Station.get_all
    puts "Your stations"
    puts stations

    puts "Choose station by index from 0 to #{stations.size - 1}"
    gets.chomp.to_i
  end

  def choose_train
    trains = Train.get_all
    puts "Your trains:"
    puts trains

    puts "Choose train by index from 0 to #{trains.size - 1}"
    gets.chomp.to_i
  end

  def create_train!(number, type, carriages_count)
    carriage = get_carriage(type)
    train = get_train(number, type)
    carriages_count.times { train.add_carriage(carriage) }
    puts "Train with number #{number}, type #{type} has been created with #{carriages_count} carriages"
  end

  def station_input
    puts "Input name of the station"
    gets.chomp
  end

  def train_input
    puts "Input number of the train"
    number = gets.chomp

    puts 'Input type("cargo" for cargo or "passenger" for passenger) of the train'
    type = gets.chomp

    puts "Input count of carriages"
    carriages_count = gets.chomp.to_i

    return number, type, carriages_count
  end

  def get_train(number, type)
    case type
    when "cargo"
      CargoTrain.new(number, [])
    when "passenger"
      PassengerTrain.new(number, [])
    else
      Train.new(number, type, [])
    end
  end

  def get_carriage(type)
    case type
    when "cargo"
      CargoCarriage.new
    when "passenger"
      PassengerCarriage.new
    else
      Carriage.new
    end
  end

  def move_train!(train_index, station_index)
    train = Train.find(train_index)
    route = Route.new(train.current_station, Station.find(station_index))
    train.route = route
    train.go
    puts "Train went from #{route.from} to #{route.to}"
  end

  def check_station_index?(index)
    Station.find(index).nil?
  end

  def check_train_index?(index)
    Train.find(index).nil?
  end
end
