MAXIMO = 60

items = [
  # [:peso, :beneficio],
  [30, 40],
  [10, 24],
  [8, 23],
  [4, 11],
  [7, 24],
  [15, 32],
  [7, 5],
  [20, 32],
  [25, 33]
]

bin_matrix = (0..2**items.size - 1).map { |i| i.to_s(2).rjust(items.size, '0').split('').map(&:to_i) }
results = bin_matrix.map.with_index(0)  do |i, index|
  [
    index,
    items.map(&:first).zip(i).map { |j| j.inject(:*) }.sum,
    items.map(&:last).zip(i).map { |j| j.inject(:*) }.sum
  ]
end.select { |i| i[1] <= MAXIMO }
max_value = results.max { |i| i[2] }
max_value << bin_matrix[max_value[0]]

puts 'Respuesta:'
puts [:decimal,:peso,:beneficio,:binario].zip(max_value).to_h
