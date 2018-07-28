vowels = ['a', 'e', 'i', 'o', 'u']
vowels_hash = Hash.new
index = 1
('a'..'z').each do |letter|
  if vowels.include?(letter)
    vowels_hash[letter.to_sym] = index
  end
  index += 1
end
puts vowels_hash