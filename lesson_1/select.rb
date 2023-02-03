def select(array)
  counter = 0
  new_arr = []

  while counter < array.size
    element = yield(array[counter])
    new_arr << array[counter] if element
    counter += 1
  end

  new_arr
end

array = [1, 2, 3, 4, 5]

p select(array) { |num| num.odd? }      # => [1, 3, 5]
p select(array) { |num| puts num }      # => [], because "puts num" returns nil and evaluates to false
p select(array) { |num| num + 1 }       # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true
