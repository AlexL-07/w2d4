# General Problems

# Write a method no_dupes?(arr) that accepts an array as an arg and returns an new array containing the elements that were not repeated in the array.
def no_dupes?(arr)
    new_arr = []
    count = Hash.new(0)

    arr.each {|el| count[el] += 1}
    
    count.each {|k, v| new_arr << k if v == 1}
    
    new_arr
end

# p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
# p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
# p no_dupes?([true, true, true])            # => []

# Write a method no_consecutive_repeats?(arr) that accepts an array as an arg. 
# The method should return true if an element never appears consecutively in the array; it should return false otherwise.
def no_consecutive_repeats?(arr)
    arr.each_with_index do |el, i|
        return false if arr[i] == arr[i + 1]
    end
    true
end

# p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
# p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# p no_consecutive_repeats?(['x'])                              # => true

# Write a method char_indices(str) that takes in a string as an arg.
# The method should return a hash containing characters as keys.
# The value associated with each key should be an array containing the indices where that character is found.

def char_indices(str)
    indexes = Hash.new {|h,k| h[k] = []}
    str.each_char.with_index do |char, i|
        indexes[char] << i
    end

    indexes
end

# p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
# p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

# Write a method longest_streak(str) that accepts a string as an arg.
# The method should return the longest streak of consecutive characters in the string.
# If there are any ties, return the streak that occurs later in the string.
def longest_streak(str)
    current_streak = ""
    best_streak = ""

    (0...str.length).each do |idx|
        if str[idx] == str[idx - 1] || idx == 0 
            current_streak += str[idx]
        else
            current_streak = str[idx]
        end

        best_streak = current_streak if current_streak.length >= best_streak.length
    end

    best_streak
end

# p longest_streak('a')           # => 'a'
# p longest_streak('accccbbb')    # => 'cccc'
# p longest_streak('aaaxyyyyyzz') # => 'yyyyy
# p longest_streak('aaabbb')      # => 'bbb'
# p longest_streak('abc')         # => 'c'

# Write a method bi_prime?(num) that accepts a number as an arg and 
# returns a boolean indicating whether or not the number is a bi-prime.
# A bi-prime is a positive integer that can be obtained by multiplying two prime numbers.
def bi_prime?(num)
    factors = []
    (2...num).each do |f1|
        (2...num).each do |f2|
            factors.push(f1, f2) if f1 * f2 == num
        end
    end


    i = 0 
    while i < factors.length - 1
        if is_prime?(factors[i]) && is_prime?(factors[i + 1])
            return true
        end
        i += 2
    end
    false

    # Class Solution
    # prime_facts = prime_factors(num)

    # prime_facts.any? do |a|
    #     b = num / a * 1.0
    #     prime_facts.include?(b)
    # end

end

def is_prime?(n)
    return false if n < 2
    (2...n).none? {|f| n % f == 0}
end 

# def prime_factors(n)
#     (2..n).select {|f| n % f == 0 && is_prime?(f)}
# end

# p bi_prime?(14)   # => true
# p bi_prime?(22)   # => true
# p bi_prime?(25)   # => true
# p bi_prime?(94)   # => true
# p bi_prime?(24)   # => false
# p bi_prime?(64)   # => false

# A Caesar cipher takes a word and encrypts it by offsetting each letter in the word by a fixed number, called the key.
# Given a key of 3, for example: a -> d, p -> s, and y -> b.
# A Vigenere Cipher is a Caesar cipher, but instead of a single key, a sequence of keys is used.
# Write a method vigenere_cipher(message, keys) that accepts a string and a key-sequence as args, returning the encrypted message.
# Assume that the message consists of only lowercase alphabetic characters.
def vigenere_cipher(message, keys)
    alphabet = ("a".."z").to_a
    new_str = ""
    
    message.each_char.with_index do |char, i|
        first_index = alphabet.index(char)
        key = keys[i % keys.length]
        second_index = first_index + key
        new_char = alphabet[second_index % alphabet.length]
        new_str += new_char
    end

    new_str
end

# p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# p vigenere_cipher("yawn", [5, 1])             # => "dbbo"

# Write a method vowel_rotate(str) that accepts a string as an arg and
# returns the string where every vowel is replaced with the vowel that appears before it sequentially in the original string.
# The first vowel of the string should be replaced with the last vowel.

def vowel_rotate(str)
    vowels = "aeiou"
    new_str = str[0..-1]

    vowel_idxs = (0...str.length).select {|i| vowels.include?(str[i])}
    rotated_vowel_idxs = vowel_idxs.rotate(-1)

    vowel_idxs.each_with_index do |vowel_idx, i|
        new_vowel = str[rotated_vowel_idxs[i]]
        new_str[vowel_idx] = new_vowel
    end

    new_str
end

# p vowel_rotate('computer')      # => "cempotur"
# p vowel_rotate('oranges')       # => "erongas"
# p vowel_rotate('headphones')    # => "heedphanos"
# p vowel_rotate('bootcamp')      # => "baotcomp"
# p vowel_rotate('awesome')       # => "ewasemo"


# Proc Problems

# Extend the string class by defining a String#select method that accepts a block.
# The method should return a new string containing characters of the original string that return true when passed into the block.
# If no block is passed, then return the empty string.
# Do not use the built-in Array#select in your solution.
class String
    def select(&prc)
        return new_str if prc.nil?
        new_str = ""
        
        self.each_char do |char|
            new_str += char if prc.call(char)
        end

        new_str
    end
end

# p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
# p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
# p "HELLOworld".select          # => ""

# Extend the string class by defining a String#map! method that accepts a block.
# The method should modify the existing string by replacing every character with the result of calling the block, 
# passing in the original character and it's index.
# Do not use the built-in Array#map or Array#map! in your solution.
class String
    def map!(&prc)
        self.each_char.with_index do |char, i|
            self[i] = prc.call(char, i)
        end
        self
    end
end

# word_1 = "Lovelace"
# word_1.map! do |ch| 
#     if ch == 'e'
#         '3'
#     elsif ch == 'a'
#         '4'
#     else
#         ch
#     end
# end
# p word_1        # => "Lov3l4c3"

# word_2 = "Dijkstra"
# word_2.map! do |ch, i|
#     if i.even?
#         ch.upcase
#     else
#         ch.downcase
#     end
# end
# p word_2        # => "DiJkStRa"



# Recursion Problems

# Write a method multiply(a, b) that takes in two numbers and returns their product.
# You must solve this recursively (no loops!)
# You must not use the multiplication (*) operator
def multiply(a, b)
    return 0 if b == 0

    if b < 0
        -(a + multiply(a,(-b) - 1))
    else
        a + multiply(a, b - 1)
    end
end

# p multiply(3, 5)        # => 15
# p multiply(5, 3)        # => 15
# p multiply(2, 4)        # => 8
# p multiply(0, 10)       # => 0
# p multiply(-3, -6)      # => 18
# p multiply(3, -6)       # => -18
# p multiply(-3, 6)       # => -18

# The Lucas Sequence is a sequence of numbers. 
# The first number of the sequence is 2. The second number of the Lucas Sequence is 1.
# To generate the next number of the sequence, we add up the previous two numbers. 
# For example, the first six numbers of the sequence are: 2, 1, 3, 4, 7, 11, ...
# Write a method lucasSequence that accepts a number representing a length as an arg.
# The method should return an array containing the Lucas Sequence up to the given length. Solve this recursively.

def lucas_sequence(length)
    return [] if length == 0
    return [2] if length == 1
    return [2, 1] if length == 2
    
    seq = lucas_sequence(length - 1)
    seq << seq[-1] + seq[-2]
    seq
end 

# p lucas_sequence(0)   # => []
# p lucas_sequence(1)   # => [2]    
# p lucas_sequence(2)   # => [2, 1]
# p lucas_sequence(3)   # => [2, 1, 3]
# p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
# p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]

# The Fundamental Theorem of Arithmetic states that every positive integer 
# is either a prime or can be represented as a product of prime numbers.
# Write a method prime_factorization(num) that accepts a number and 
# returns an array representing the prime factorization of the given number.
# This means that the array should contain only prime numbers that multiply together to the given num.
# The array returned should contain numbers in ascending order. Do this recursively.
def prime_factorization(num)
    (2...num).each do |f|
        if num % f == 0 
            f2 = num / f 
            return [*prime_factorization(f), *prime_factorization(f2)]
        end
    end

    [num]
end

# p prime_factorization(12)     # => [2, 2, 3]
# p prime_factorization(24)     # => [2, 2, 2, 3]
# p prime_factorization(25)     # => [5, 5]
# p prime_factorization(60)     # => [2, 2, 3, 5]
# p prime_factorization(7)      # => [7]
# p prime_factorization(11)     # => [11]
# p prime_factorization(2017)   # => [2017]



