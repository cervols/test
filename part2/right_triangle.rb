def get_user_input
  input = ""

  while input.empty? do
    input = gets.chomp
  end

  #did user enter a number? is it a positive number?
  while input.to_i <= 0
    puts "Please, enter a correct value!"
    input = get_user_input
  end

  input.to_f
end

sides = []  #array with triangle sides

puts "Welcome in the \"Right triangle\" program!"

puts "Please, enter the first side of triangle:"
sides << get_user_input
puts "now enter the second side:"
sides << get_user_input
puts "and the third one:"
sides << get_user_input

if sides.uniq.length == 1
  puts "This triangle is isosceles and equilateral, but not right."
  abort
end

#extract max side (hypotenuse). 2 other sides (cathetus) remain in array
max_side = sides.sort!.pop

sum_of_squares_cathetus = sides.sum { |cathetus| cathetus**2 }

right_triangle = max_side**2 == sum_of_squares_cathetus

if right_triangle && sides.uniq.length == 1
  puts "This is a right isosceles triangle with a hypotenuse = #{max_side}"
elsif right_triangle
  puts "This is a right triangle with a hypotenuse = #{max_side}"
else
  puts "This is not a right triangle"
end
