puts "What's your name?"
name = gets.chomp

puts "What's your height?"
height = gets.chomp.to_i

 weight = height - 110

if weight > 0
  puts "#{name}, Ваш идеальный вес - #{weight}кг."
else
  puts "#{name}, Ваш вес уже оптимальный"
end
