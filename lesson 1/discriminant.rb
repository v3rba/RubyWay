require "cmath"

class Foo
  def self.math_plus(a, b, d)
    (-1 * b + Math.sqrt(d)) / (2 * a)
  end

  def self.math_minus(a, b, d)
    (-1 * b - Math.sqrt(d)) / (2 * a)
  end
end

print 'a: '
a = gets.to_f

print 'b: '
b = gets.to_f

print 'c: '
c = gets.to_f

d = (b * b - 4 * a * c)

# Проверяем условие, если дискриминант больше или равен 0, то находим корни и выводим
abort('Дискриминант меньше 0, корней нет.') if d < 0

if d > 0 # Если дискриминант больше или равен 0
  x1 = Foo.math_plus(a, b, d)
  puts "Первый корень равен #{x1}."
  x2 = Foo.math_minus(a, b, d)
  puts "Второй корень равен #{x2}."
else
  x = Foo.math_plus(a, b, d)
  puts "Первый корень равен #{x}."
  puts "Второй корень равен #{x}."
end
