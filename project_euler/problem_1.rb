arr = (1...1000).to_a
arr = arr.filter { |e| e % 3 == 0 || e % 5 == 0 }
p arr.reduce(0) { |acc, val| acc += val }
