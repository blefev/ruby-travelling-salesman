class TravellingSalesman
  def intialize(graph)
    @graph = graph
  end

  def brute_force(start)
    nodes = (0..(@graph.size)).dup.delete(start)

    nodes.permutation
  end
end