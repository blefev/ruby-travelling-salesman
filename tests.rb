require "minitest/reporters"
require "minitest/autorun"
require "minitest/hooks/test"
require_relative "./graph.rb"
require_relative "./travelling_salesman.rb"
require_relative "./tsp_tools.rb"

GRAPH_SIZE = 4

MiniTest::Reporters.use!

class CircleTests < Minitest::Test
  def setup
    puts "============="
    radius = 100
    (@graph, @expected_dist) = TSPTools.generate_random_circular_graph_cost_matrix(GRAPH_SIZE, radius)
    puts "Graph: #{@graph}"
    @tsp = TravellingSalesman.new(@graph)
    puts "Expecting: #{@expected_dist}"
  end

  def test_circle_brute_force
    ans = @tsp.brute_force
    puts "brute ans: #{ans}"
    assert(@expected_dist.round - ans < 3)
  end

  def test_circle_greedy
    ans = @tsp.greedy
    puts "greedy ans: #{ans}"
    assert(@expected_dist.round - ans < 3)
  end

  def test_circle_dp
    ans = @tsp.dp
    puts "dp ans: #{ans}"
    assert(@expected_dist.round - ans < 3)
  end
end