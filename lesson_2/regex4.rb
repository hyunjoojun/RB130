def mysterious_math(eq)
  new_eq = []
  array = eq.split
  array.each do |op|
    if op.match?(/[+\-*\/]/)
      new_eq << '?'
    else
      new_eq << op
    end
  end
  new_eq.join(' ')
end

p mysterious_math('4 + 3 - 5 = 2')           # -> '4 ? 3 ? 5 = 2'
p mysterious_math('(4 * 3 + 2) / 7 - 1 = 1') # -> '(4 ? 3 ? 2) ? 7 ? 1 = 1'
