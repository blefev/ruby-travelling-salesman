require_relative "./graph.rb"
require_relative "./travelling_salesman.rb"
require_relative "./tools.rb"

GRAPH_SIZE = 10
MAX_DIST = 10

def main
  (g, circle_pairs) = Tools.generate_random_circular_graph_cost_matrix(GRAPH_SIZE, 16)
  puts g.to_s
  puts
  p circle_pairs
  puts
  puts

  tsp = TravellingSalesman.new(g)


  puts "Brute force: #{tsp.brute_force}"
  puts "Dp2: #{tsp.dp2}"
  puts "Greedy: #{tsp.greedy}"

end

def gen_graph(size, max=MAX_DIST)

end

main