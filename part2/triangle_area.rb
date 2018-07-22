def get_user_input
  input = ""

  while input == "" do
    input = STDIN.gets.chomp
  end

  while input.to_i == 0
    puts "Please, enter a correct value!"
    input = get_user_input
  end

  return input.to_f

end

puts "Welcome in the \"Area of triangle\" program!"
puts "Please, enter the base of triangle"
base = get_user_input
puts "Please, enter height of the triangle"
height = get_user_input

triangle_area = base * height / 2

puts "Area of triangle with base #{base} and height #{height}:\n#{triangle_area}"
