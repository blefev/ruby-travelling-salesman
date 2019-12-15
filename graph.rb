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

  def get(from, to)
    @matrix[from][to]
  end

  def path_weight(path)
    path.each_cons(2).reduce(0) do |dist, from, to|
        dist + get(from, to)
    end
  end

  def to_s
    0.upto(size-1).reduce("") do |str, i|
        str +  "#{@matrix[i]}\n"
    end
  end
end