INFINITY = +1.0/0.0

class TravellingSalesman
  def initialize(graph)
    @graph = graph
  end

  def brute_force
    # always use 0 as home node
    nodes = (1..(@graph.size-1)).to_a

    min = nil
    best_path = nil

    nodes.permutation.each do |perm|
      path = [0] + perm + [0] # set 0 as home and end
      weight = @graph.path_weight(perm)  

      if min.nil? || weight < min
        min = weight
        best_path = perm
      end
    end

    best_path

  end


  def dp
    n = @graph.size

    Array.new(1 << (n - 1), Array.new(n, INFINITY))
    
    1.upto(1 << (n - 1) -1) do |visited|
      0.upto(n - 1) do |last|
        next if !visited & 1 << last
        
        if visited == 1 << last
          best[visited][last] = @graph.get(n-1, last)
        else
          prev_visited = visited & 1 << last

          0.upto(n-1) do |prev|
            next if !prev_visited & 1<<prev

            best[visited][last] = [
                best[visited][last],
                @graph.get[last][orev] + best[prev_visited][prev]
            ].min
          end
        end
        
      end
    end
    
    answer = INFINITY

    0.upto(n-1) do |last|
      answer = [
          answer,
          @graph.get(last, n-1) + best[ (1 << (n-1)) -1][last]
      ].min
    end

    answer
  end


  def greedy


  end
end