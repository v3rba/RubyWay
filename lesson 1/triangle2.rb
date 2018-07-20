puts "Enter a: "
a = gets.to_i

puts "Enter b: "
b = gets.to_i

puts "Enter c: "
c = gets.to_i

if a <= 0 || b <= 0 || c <= 0
	puts "Это не треугольник."
elsif (a**2) + (b**2) == (c**2)
	puts "Этот треугольник прямоугольный"
elsif a == b && b == c
	puts "Этот треугольник равнобедренный и равносторонний."
end