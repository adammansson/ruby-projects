def caesar_shift(number, lower_bound, shift)
  ((((number - lower_bound) + shift) % 26) + lower_bound)
end

def caesar_cipher(sentence, shift)
  numbers_from_sentence = sentence.bytes
  shifted_sentence = numbers_from_sentence.map do |number|
    if number.between?(65, 90)
      caesar_shift(number, 65, shift)
    elsif number.between?(97, 122)
      caesar_shift(number, 97, shift)
    else
      number
    end
  end
  shifted_sentence.map { |number| number.chr }.join
end

puts caesar_cipher("What a string!", 5)

