require_relative "./graph.rb"
require_relative "./travelling_salesman.rb"
require_relative "./tools.rb"

GRAPH_SIZE = 100
GRAPH_SIZE = 100
MAX_DIST = 10

def main
  (g, circle_pairs) = Tools.generate_random_circular_graph_cost_matrix(GRAPH_SIZE, 100)
  puts g.to_s
  puts
  p circle_pairs
  puts
  puts

  tsp = TravellingSalesman.new(g)
  ans = tsp.dp3
  p ans
end

def gen_graph(size, max=MAX_DIST)

end

main