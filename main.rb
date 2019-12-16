require_relative "./graph.rb"
require_relative "./travelling_salesman.rb"

GRAPH_SIZE = 4
MAX_DIST = 10

def main
  g = gen_graph(GRAPH_SIZE)
  puts g.to_s
puts

  tsp = TravellingSalesman.new(g)
  ans = tsp.greedy
  p ans
end

def gen_graph(size, max=MAX_DIST)

end

main