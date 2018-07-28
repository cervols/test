fibonacci_numbers = [0, 1]
while fibonacci_numbers.last < 100
  fibonacci_numbers << fibonacci_numbers[-1] + fibonacci_numbers[-2]
end
fibonacci_numbers.delete_at(-1)
puts fibonacci_numbers
