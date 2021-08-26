require 'pry'

PESO_MAXIMO = 600
VOLUMEN_MAXIMO = 1500
DEBUG = false

items = [
  # [:peso, :volumen, :beneficio]
  [15, 30, 40],
  [12, 24, 28],
  [10, 21, 22],
  [13, 24, 30],
  [22, 40, 54],
  [16, 37, 38],
  [10, 40, 24],
  [14, 18, 35]
]

solutions = []

pesos = items.map { |i| i[0] }
volumenes = items.map { |i| i[1] }
beneficios = items.map { |i| i[2] }
max_p = pesos.map { |i| PESO_MAXIMO / i }
max_v = volumenes.map { |i| VOLUMEN_MAXIMO / i }
max = max_p.zip(max_v).map(&:min)
b_p = beneficios.zip(pesos).map { |b, p| b.to_f / p }
b_v = beneficios.zip(volumenes).map { |b, v| b.to_f / v }
mg = b_p.zip(b_v).map { |i, j| (i * j)**0.5 }

mvi_i = mg.index mg.max

base_arr = Array(0) * items.size
base_arr[mvi_i] = max[mvi_i]
solutions << base_arr

base_arr = base_arr.dup
base_arr[mvi_i] -= 1

items.each_with_index do |_, index|
  next if index == mvi_i

  is_valid = true
  new_arr = base_arr.dup
  while is_valid
    new_arr[index] += 1

    if new_arr.zip(volumenes)
              .map { |i, j| i * j }
              .sum <= VOLUMEN_MAXIMO &&
       new_arr.zip(pesos)
              .map { |i, j| i * j }
              .sum <= PESO_MAXIMO
      solutions << new_arr
    else
      is_valid = false
    end
  end
end

benefits = solutions.map{ |solution| solution.zip(beneficios).map { |i, j| i * j }.sum}
max_benefit = benefits.max

best_item_index = benefits.index max_benefit

if DEBUG
  puts 'Soluciones:'
  pp solutions
end

puts 'Mejor solución:'
pp solutions[best_item_index]
puts "Beneficio: #{max_benefit}"
