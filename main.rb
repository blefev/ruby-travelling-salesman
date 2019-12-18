require_relative "./graph.rb"
require_relative "./travelling_salesman.rb"
require_relative "./tools.rb"

GRAPH_SIZE = 10
MAX_DIST = 10

def main
  #(g, circle_pairs) = Tools.generate_random_circular_graph_cost_matrix(GRAPH_SIZE, 16)
  # puts g.to_s
  # puts
  # p circle_pairs
  # puts
  # puts

  g = Graph.new(4)

  g.add(0,1,20)
  g.add(0,2,42)
  g.add(0,3,35)
  g.add(1,2,30)
  g.add(1,3,34)
  g.add(2,3,12)

  tsp = TravellingSalesman.new(g)


  puts "Brute force: #{tsp.brute_force}"
  puts "Dp2: #{tsp.dp2}"
  puts "Dp3: #{tsp.dp3}"
  puts "Greedy: #{tsp.greedy}"

end

def gen_graph(size, max=MAX_DIST)

end

main