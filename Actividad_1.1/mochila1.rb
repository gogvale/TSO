DEBUG = false
COSTO_MAXIMO = 600
solutions = []

items = [
  # [Beneficio, Peso]
  [15, 40],
  [12, 28],
  [10, 22],
  [13, 30],
  [22, 54],
  [16, 38],
  [10, 24],
  [14, 35]
]

b_p = items.map { |i, j| j.to_f / i }
most_valuable_item_index = b_p.index b_p.max
most_valuable_item = items.delete_at most_valuable_item_index

empty_arr = Array(0) * items.size
most_valuable_item_count = COSTO_MAXIMO / most_valuable_item.last
empty_arr.insert(most_valuable_item_index, most_valuable_item_count)
solutions << empty_arr

most_valuable_item_count -= 1

new_costo_maximo = COSTO_MAXIMO - most_valuable_item_count * most_valuable_item.last
items.each_with_index do |item, index|
  (1..new_costo_maximo / item.last).each do |i|
    new_arr = Array(0) * items.size
    new_arr[index] = i
    new_arr.insert(most_valuable_item_index, most_valuable_item_count)
    solutions << new_arr
  end
end

items.insert(most_valuable_item_index, most_valuable_item)

results = solutions.map do |i|
  [items.map(&:first).zip(i).map { |x, y| x * y }.sum,
   items.map(&:last).zip(i).map { |x, y| x * y }.sum]
end

benefits = results.map(&:first)
solution_index = benefits.index benefits.max
solution = solutions[solution_index]
# most_valuable_item_count = solution.pop
# solution.insert(most_valuable_item_index, most_valuable_item_count)

if DEBUG
  puts 'Posibilidades:'
  pp solutions
end

puts "\nSolución:"
pp solution
pp %i[Beneficio Peso].zip(results[solution_index]).to_h
