puts "Как тебя зовут?"
name = gets.chomp

puts "В каком году ты родился?"
year = gets.chomp

puts "Привет, #{name}! Тебе #{2018 - year.to_i} лет"