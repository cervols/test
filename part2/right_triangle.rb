def get_user_input
  input = ""

  while input == "" do
    input = STDIN.gets.chomp
  end

  #did user enter a number? is it a positive number?
  while input.to_i <= 0
    puts "Please, enter a correct value!"
    input = get_user_input
  end

  return input.to_f

end

sides = []  #array with triangle sides

puts "Welcome in the \"Right triangle\" program!"

puts "Please, enter the first side of triangle:"
sides << get_user_input
puts "now enter the second side:"
sides << get_user_input
puts "and the third one:"
sides << get_user_input

case sides.uniq.length
when 1
  puts "This triangle is isosceles and equilateral, but not right."
  abort
when 2
  puts "This triangle is isosceles"
end

max_side = sides.sort!.pop

sum_of_squares_sides = sides.sum { |i| i * i}

if max_side**2 == sum_of_squares_sides**2
  puts "This is a right triangle with a hypotenuse = #{max_side}"
else
  puts "This is not a right triangle"
end
