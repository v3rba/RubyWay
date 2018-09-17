require_relative 'train'
require_relative 'cargotrain'
require_relative 'passangertrain'
require_relative 'station'
require_relative 'route'

class TextInterface
  
  def session
    puts "Введите -- ct -- для создания поезда "
    puts "Введите -- cs -- для создания станций "
    puts "Введите -- exit -- для выхода из программы "
    loop do
      command = gets.chomp.downcase
      case command
        when 'ct'
          ct
        when 'cs'
          cs
        when 'exit'
          break
      end
    end
  end

private
  
  def ct
    puts "Введите тип поезда --- car\\pass--- грузовой\\пассажирский"
    type = gets.chomp.downcase
    puts "Введите номер поезда"
    train_name = gets.chomp
    if type == 'car'
      CargoTrain.new(train_name)
    elsif type == 'pass'
      PassangerTrain.new(train_name)
    end
  rescue RuntimeError => e
    puts e.message
  end

  def cs
    puts "Введите название станций"
    station_name = gets.chomp
    Station.new(station_name)
  rescue RuntimeError => e
    puts e.message
  end

end

ti = TextInterface.new()
ti.session
