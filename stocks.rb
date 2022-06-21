def stock_picker(prices)
  max_diff = 0
  max_indices = [0, 0]
  prices.each_with_index do |value, index|
    prices[index + 1, prices.length - 1].each_with_index do |other_value, other_index|
      if (other_value - value) > max_diff
        max_diff = other_value - value
        max_indices = [index, other_index + index + 1]
      end
    end
  end
  max_indices
end

p stock_picker([17,3,6,9,15,8,6,1,10])

