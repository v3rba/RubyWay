puts "What's your name?"
name = gets.chomp

puts "What's your height?"
height = gets.chomp

weight = height.to_i - 110

if weight > 0
	puts "#{name}, Ваш идеальный вес - #{weight}кг."
else
	puts "#{name}, Ваш вес уже оптимальный"
end

