# def reduce(array, acc=0)
#   array.each do |ele|
#     acc = yield(acc, ele)
#   end
#   acc
# end

def reduce(*arg)
  acc = 0
  acc = arg.last if arg.last.instance_of?(Integer)

  arg.first.each do |ele|
    acc = yield(acc, ele)
  end

  acc
end

array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
# reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass
