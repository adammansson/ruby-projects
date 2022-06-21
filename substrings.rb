def substrings(sentence, dictionary)
  sentence.split.reduce(Hash.new(0)) do |accumulator, value|
    dictionary.each do |word|
      if value.downcase.include?(word.downcase)
        accumulator[word] += 1
      end
    end
    accumulator
  end
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
p substrings("below", dictionary)
p substrings("Howdy partner, sit down! How's it going?", dictionary)

