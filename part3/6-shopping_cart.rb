puts "Welcome in the \"Shopping cart\" program!\n" +
      "(enter \"stop\" as product name if you want to exit)"
puts "#{'-' * 25}"

cart = Hash.new
grand_total = 0

loop do
  puts "Enter product:"
  product = gets.chomp
  break if product.downcase == 'stop'

  puts "Unit price ($):"
  price = gets.chomp.to_f
  
  puts "Quantity:"
  quantity = gets.chomp.to_f

  cart[product.to_sym] = {price => quantity}
end

puts cart

cart.each do |product, sub_hash|
  sub_hash.each do |price, quantity|
    total = price * quantity
    grand_total += total
    puts "#{product}: #{total}$"
  end
end

puts "Grand Total: #{grand_total}$"
