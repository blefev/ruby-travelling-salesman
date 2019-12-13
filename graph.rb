class Graph
  attr_reader :matrix
  attr_reader :size
  def initialize(size)
    # size is number of vertices
    @size = size
    @matrix = Array.new(size) { Array.new(size, 0)}
  end

  def add(from, to, weight=1)
    @matrix[from][to] = weight
    @matrix[to][from] = weight
  end

  def path_weight(path)
    path.reduce(0) do |a,b|
      
    end
  end
end