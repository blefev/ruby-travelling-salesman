require_relative "./graph.rb"
require_relative "./travelling_salesman.rb"
require_relative "./tsp_tools.rb"
require_relative "./bencher.rb"

def run_benchmarks


  tools = TSPTools.new
  bencher = Bencher.new(10, 10)

  ["brute_force", "greedy"].each do |method|
    bencher.bench(method) do |n|
      # make graph of size n, return lambda for bench to run
      graph = TSPTools.generate_random_circular_graph_cost_matrix(n, 16)

      tsp = TravellingSalesman.new(graph)
      # this returns a lambda to the bench function
      -> { tsp.send(method) }
    end
  end



end

run_benchmarks