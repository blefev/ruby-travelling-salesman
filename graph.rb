class Graph
  attr_reader :adjacency_matrix
  def initialize(adjacencies = nil)
    unless adjacencies.nil?
      @adjacency_matrix = adjacencies;
    end
  end


end