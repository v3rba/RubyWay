puts " Сторона №1: "
a = gets.chomp.to_i

puts "Сторона №2: "
b = gets.chomp.to_i

puts "Сторона №3: "
c = gets.chomp.to_i

=begin
	if a > 0 && b > 0 && c > 0
	
else
	puts "Стороны не могут быть отрицательными!"
end
=end

if a*a == b*b+c*c || b*b == a*a+c*c || c*c == b*b+a*a
	puts "Прямоугольный треугольник."
elsif a*a > b*b+c*c || b*b > a*a+c*c || c*c > b*b+a*a
 	 puts "Тупоугольный треугольник."
else a >= b + c || b >= a + c || c >= b + a
	puts "Это не треугольник."
end

if a == b || a == b || a == c || b == a || b == c || c == a || c == b
	puts "Равнобедренный треугольник"
end

