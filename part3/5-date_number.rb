months = { 1 => 31,
           2 => 28,
           3 => 31,
           4 => 30,
           5 => 31,
           6 => 30,
           7 => 31,
           8 => 31,
           9 => 30,
           10 => 31,
           11 => 30,
           12 => 31
         }
date_number = 0

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
if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
  months[2] = 29
  puts "#{year} is a leap year"
else
  puts "#{year} isn't a leap year"
end

#count the number of days in previous months
(1...month).each { |month| date_number += months[month] }
#add the number of days in the entered month
date_number += day

puts "#{day}/#{month}/#{year} is the #{date_number} day in the year"
