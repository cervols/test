days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Enter the day of the month (1-31)"
day = gets.chomp.to_i
if day < 1 || day > 31
  puts "You entered wrong day"
  abort
end

puts "Enter the month (1-12)"
month = gets.chomp.to_i
if month < 1 || month > 12
  puts "You entered wrong month"
  abort
end

puts "Enter the year"
year = gets.chomp.to_i

#February has 29 days if this is a leap year
if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  days_in_months[1] = 29
  puts "#{year} is a leap year"
else
  puts "#{year} isn't a leap year"
end

date_number = day

#add the number of days in previous months
(1...month).each { |month_number| date_number += days_in_months[month_number-1] }

puts "#{day}/#{month}/#{year} is the #{date_number} day in the year"
