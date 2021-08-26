# Tecnica del vecindario

DEBUG = true
COSTO_MAXIMO = 600
solutions = []

items = [
  # [Beneficio, Peso]
  [35, 15],
  [28, 12],
  [22, 10],
  [30, 13],
  [54, 22],
  [38, 16],
  [24, 10],
  [35, 14]
]

b_p = items.map { |i, j| i.to_f / j }
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
