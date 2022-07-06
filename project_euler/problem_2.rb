result = [0, 1]
while result.last < 4_000_000 do
  result << result[-1] + result[-2]
end

p result.reduce { |acc, val| val % 2 == 0 ? acc += val : acc }
