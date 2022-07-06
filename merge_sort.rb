def merge(arr1, arr2)
  result = []
  while arr1.length > 0 && arr2.length > 0 do
    if arr1.first <= arr2.first
      result << arr1.shift
    else
      result << arr2.shift
    end
  end
  result += arr1
  result += arr2
  return result
end

def merge_sort(arr)
  return arr if arr.length == 1
  middle = (arr.length / 2).round
  arr1 = merge_sort(arr[0...middle])
  arr2 = merge_sort(arr[middle..-1])
  return merge(arr1, arr2)
end

arr = 25.times.map{ rand(100) + 1 }
p arr
p merge_sort(arr)

