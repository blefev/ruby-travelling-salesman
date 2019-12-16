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
  g = Graph.new(size)
  rng = Random.new

  0.upto(size-1) do |i|
    i.upto(size-1) do |j|
      # don't add weight if same node
      next if i == j
      # generate random weight between 1..100
      g.add(i, j, rng.rand(1..max))
    end
  end
  g
end

main