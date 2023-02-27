def reduce(collection, default=nil)
  acc = default || collection[0]
  index = default ? 0 : 1

  loop do
    acc = yield(acc, collection[index])
    index += 1
    break if index >= collection.length
  end

  acc
end

array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num } == 15
p reduce(array, 10) { |acc, num| acc + num } == 25
# p reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass
p reduce(['a', 'b', 'c']) { |acc, value| acc += value } == 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } == [1, 2, 'a', 'b']
p reduce(array, 1) { |acc, num| acc + num } == 16
