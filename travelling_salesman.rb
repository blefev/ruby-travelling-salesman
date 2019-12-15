class TravellingSalesman
  def initialize(graph)
    @graph = graph
  end

  def brute_force(start)
    nodes = (0..(@graph.size-1)).to_a
    nodes.delete(start)

    min = nil
    best_path = nil

    nodes.permutation.each do |perm|
      weight = @graph.path_weight(perm)  

      if min.nil? || weight < min
        min = weight
        best_path = perm
      end
    end

    best_path

  end
end