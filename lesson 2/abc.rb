vowel = ["a","e","i","o","u","y"]
vowel_hash = {}

("a".."z").each_with_index { |letter, ind| vowel_hash[letter] = ind if vowel.include?(letter) }
puts "#{vowel_hash}"
