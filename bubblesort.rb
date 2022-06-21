def bubble_sort(array)
  to_be_sorted = array.dup
  loop do
    did_something = false
    for i in 0..(to_be_sorted.length - 2) do
      if to_be_sorted[i] > to_be_sorted[i + 1] then
        temp = to_be_sorted[i + 1]
        to_be_sorted[i + 1] = to_be_sorted[i]
        to_be_sorted[i] = temp
        did_something = true
      end
    end
    break if !did_something
  end

  to_be_sorted
end

arr = [4,3,78,2,0,2]
p bubble_sort(arr)
p arr

