def fibs(number)
  result = []
  for i in 0...number do
    if i == 0
      result << 0
    elsif i == 1
      result << 1
    else
      result << result[i - 1] + result[i - 2]
    end
  end
  result
end

def fibs_rec(number)
  return [0, 1] if number < 3
  array = fibs_rec(number - 1)
  return array << array[-1] + array[-2]
end

p fibs(8)
p fibs_rec(8)
