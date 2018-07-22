def get_user_input
  input = ""

  while input == "" do
    input = STDIN.gets.chomp
  end

  #did user enter a zero or an other number?
  while input != "0" && input.to_i == 0
    puts "Please, enter a correct value!"
    input = get_user_input
  end

  return input.to_f

end

puts "Welcome in the \"Quadratic equation\" program!\nах^2 + bx + c = 0"

puts "Please, enter the first coefficient (a) of quadratic equation:"
a = get_user_input
puts "now enter the second coefficient (b):"
b = get_user_input
puts "and the third one (c):"
c = get_user_input

discriminant = b**2 - 4 * a * c

if discriminant < 0
  puts "Discriminant = #{discriminant}. There are no roots of the quadratic equation"
elsif discriminant == 0
  root1 = -b / (2 * a)
  puts "Discriminant = #{discriminant}\nRoots: x1 = x2 = #{root1}"
else
  root1 = (-b + Math.sqrt(discriminant)) / (2 * a)
  root2 = (-b - Math.sqrt(discriminant)) / (2 * a)
  puts "Discriminant = #{discriminant}\nRoots: x1 = #{root1}; x2 = #{root2}"
end
