require_relative "./graph.rb"
require_relative "./travelling_salesman.rb"
require_relative "./tsp_tools.rb"
require_relative "./bencher.rb"

def run_benchmarks
  max_inputs = {
      "brute_force" => 11,
      "greedy" => 300,
      "dp" => 15
  }

  functions = [
      "brute_force",
      "greedy",
      "dp"
  ]

  tools = TSPTools.new
  bencher = Bencher.new(max_inputs, 20)

  functions.each do |method|
    puts "======================="
    puts "Benching #{method}"
    bencher.bench(method) do |n|
      # make graph of size n, return lambda for bench to run
      graph = TSPTools.generate_random_cost_matrix(n)

      tsp = TravellingSalesman.new(graph)
      # this returns a lambda to the bench function
      -> { tsp.send(method) }
    end
  end



end

run_benchmarks