def largest_prime_factor(num)
  i = 2
  while i * i <= num do
    if num % i == 0
      num /= i
    else
      i += 1
    end
  end
  return num
end

p largest_prime_factor(600851475143)
