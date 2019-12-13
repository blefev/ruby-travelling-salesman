class TravellingSalesman
  def intialize(graph)
    @graph = graph
  end

  def brute_force
    nodes = (0..(@graph.size)).to_a

    nodes.permutation
  end
end