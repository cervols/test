puts "Welcome in the \"Shopping cart\" program!\n" +
      "(enter \"stop\" as product name if you want to exit)"
puts "#{'-' * 25}"

cart = {}

loop do
  puts "Enter product:"
  product = gets.chomp
  break if product.downcase == 'stop'

  puts "Unit price ($):"
  price = gets.chomp.to_f

  puts "Quantity:"
  amount = gets.chomp.to_f

  cart[product.to_sym] = { price: price, amount: amount }
end

puts cart

grand_total = 0

cart.each do |product, price_amount|
    total = price_amount[:price] * price_amount[:amount]
    grand_total += total
    puts "#{product}: #{total}$"
end

puts "Grand Total: #{grand_total}$"
