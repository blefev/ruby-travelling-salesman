INFINITY = +1.0/0.0

require 'set'

class TravellingSalesman
  def initialize(graph)
    @graph = graph
  end

  def brute_force
    # always use 0 as home node
    nodes = (1..(@graph.size-1)).to_a

    min = nil

    nodes.permutation.each do |perm|
      path = [0] + perm + [0] # set 0 as home and end
      weight = @graph.path_weight(path)

      if min.nil? || weight < min
        min = weight
      end
    end

    min

  end





  def dp(home, tour, costs, table)
    unless table[home][tour].nil?
      return table[home][tour]
    end

    # always use 0 as home node
    nodes = (1..(@graph.size-1)).to_a

    min = nil

    nodes.permutation.each do |perm|
      path = [0] + perm + [0] # set 0 as home and end
      weight = @graph.path_weight(path)

      if min.nil? || weight < min
        min = weight
      end
    end

    min

  end






  def greedy
    n = @graph.size

    total = 0
    unvisited = (1..n-1).to_a.to_set

    from = 0

    while unvisited.length > 0
      min = INFINITY
      minnode = nil

      unvisited.each do |to|
        dist = @graph.get(from, to)
        if dist < min
          min = dist
          minnode = to
        end
      end
      

      from = minnode
      unvisited.delete(from)
      total += min
    end

    total + @graph.get(from, 0)
  end
end