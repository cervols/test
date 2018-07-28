vowels = ['a', 'e', 'i', 'o', 'u']
vowels_hash = {}
('a'..'z').each.with_index(1) do |letter, index|
  if vowels.include?(letter)
    vowels_hash[letter.to_sym] = index
  end
end
puts vowels_hash
