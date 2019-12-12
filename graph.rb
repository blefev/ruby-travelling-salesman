class Graph
  attr_reader :matrix
  def initialize(num_vertices)
    @matrix = Array.new(num_vertices) { Array.new(num_vertices, 0)}
  end

  def add(from, to, weight=1)
    @matrix[from][to] = weight
  end

  def get(from, to)
    @matrix[from][to]
  end
end