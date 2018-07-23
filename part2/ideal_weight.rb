def get_user_input
  input = ""

  while input.empty? do
    input = gets.chomp
  end

  input
end

puts "Welcome in \"Ideal weight\" program!"
puts "What is your name?"
name = get_user_input
puts "Please, enter your height"
height = get_user_input

while height.to_i == 0
  puts "Please, enter a correct height"
  height = get_user_input
end

ideal_weight = height.to_i - 110

if ideal_weight <= 0
  puts "Congratulation, #{name}! Your weight is already ideal :)"
else
  puts "#{name}, your ideal height = #{ideal_weight} kg"
end
