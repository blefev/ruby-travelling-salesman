require_relative "./graph.rb"
require_relative "./travelling_salesman.rb"
require_relative "./tsp_tools.rb"

GRAPH_SIZE = 10
MAX_DIST = 10

def main
  g = TSPTools.generate_random_circular_graph_cost_matrix(GRAPH_SIZE, 16)

  tsp = TravellingSalesman.new(g)

  puts "Brute force: #{tsp.brute_force}"
  puts "Dp: #{tsp.dp}"
  puts "Greedy: #{tsp.greedy}"

end

main