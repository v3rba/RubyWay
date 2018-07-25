puts "Enter a: "
a = gets.to_f

puts "Enter b: "
b = gets.to_f

puts "Enter c: "
c = gets.to_f

if a <= 0 || b <= 0 || c <= 0
  puts "Это не треугольник."
elsif (a**2) + (b**2) == (c**2)
  puts "Этот треугольник прямоугольный"
elsif a == b && b == c
  puts "Этот треугольник равнобедренный и равносторонний."
end
