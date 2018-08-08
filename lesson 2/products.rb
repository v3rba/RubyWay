products = {}

loop do
  puts 'Название товара: '
  product_name = gets.chomp

  puts 'Цена за единицу: '
  product_price = gets.to_i

  puts 'Количество: '
  product_amount = gets.to_f  

  if product_name == 'break'
    break
  end

  products[product_name] = { 'price' => product_price, 'amount' => product_amount }
end

puts products

total_price = 0

products.each do |key, value|
  total_price_item = 0
  total_price_item += value["price"] * value["amount"]
  total_price += total_price_item
  puts "#{key} = #{total_price_item}"
end

puts "Итоговая сумма всех покупок в корзине: #{total_price}"
