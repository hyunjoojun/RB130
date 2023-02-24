def times(max_num)
  0.upto(max_num - 1) do |num|
    yield(num)
  end
  max_num
end

times(5) do |num|
  puts num
end
