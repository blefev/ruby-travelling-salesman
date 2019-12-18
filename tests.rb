require "minitest/reporters"
require "minitest/autorun"
require_relative "./graph.rb"
require_relative "./travelling_salesman.rb"
require_relative "./tools.rb"

GRAPH_SIZE = 10

MiniTest::Reporters.use!

class CircleTests < Minitest::Test
  def setup
    radius = 16
    @graph = Tools.generate_random_circular_graph_cost_matrix(GRAPH_SIZE, radius)
    @tsp = TravellingSalesman.new(@graph)
    @expected_dist = 2 * Math::PI * radius
  end

  def test_circle_brute_force
    ans = @tsp.brute_force
    assert(@expected_dist.round - ans < 3)
  end

  def test_circle_greedy
    ans = @tsp.greedy
    assert(@expected_dist.round - ans < 3)
  end

  def test_circle_dp
    #ans = @tsp.dp
    #assert(@expected_dist.round - ans < 3)
  end
end