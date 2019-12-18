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


  def dp
    n = @graph.size

    # use bit shifting to represent what has been visited
    best = Array.new(1 << (n - 1), Array.new(n, INFINITY))
    
    1.upto(1 << (n - 1) - 1) do |visited|
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
                @graph.get(last, prev) + best[prev_visited][prev]
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




  def dp2
    n = @graph.size
    puts "n: #{n}"
    costs = {}

    1.upto(n-1) do |k|
      puts "setting: #{(1 << k).to_s(2)},#{k} = #{@graph.get(0, k)}"
      costs["#{1 << k},#{k}"] = [@graph.get(0, k), 0]
    end

    2.upto(n-1) do |subset_size|
      (1..n-1).to_a.combination(subset_size).each  do |subset|

        bits = 0
        subset.each do |bit|
          bits |= 1 << bit
        end

        subset.each do |k|
          prev = bits & ~(1 << k)

          results = []
          subset.each do |m|
            next if m == 0 or m == k
            costs["#{prev},#{m}"] = [] if costs["#{prev},#{m}"].nil?
            results.push([costs["#{prev},#{m}"].first + @graph.get(m, k), m])
          end

          costs["#{bits},#{k}"] = results.min
        end

      end
    end

    bits = (2**n = 1)

    res = []

    1.upto(n) do |k|
      puts "bits: #{bits},#{k}"
      res.push([costs["#{bits},#{k}"].first + @graph.get(k, 0), k])
    end

    (opt, parent) = res.min



    opt

  end

  def dp3()
    state = Array.new(@graph.size, Array.new((1 << @graph.size) - 1, INFINITY))

    dp3helper(0, 1, state)
  end

  def dp3helper(pos, visited, state)
    if visited == ((1 << (@graph.size)) - 1)
      return @graph.get(pos, 0)
    end

    if state[pos][visited] != INFINITY
      return state[pos][visited]
    end

    (0..@graph.size-1).each do |i|
      if i == pos || (visited & (1 << i) != 0)
        next
      end

      distance = @graph.get(pos, i) + (dp3helper(i, visited | (1 << i), state))

      if distance < state[pos][visited]
        state[pos][visited] = distance
      end
    end

    return state[pos][visited]
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

      puts "Min from #{from} to #{minnode}: #{min}"

      from = minnode
      unvisited.delete(from)
      total += min
    end

    total + @graph.get(from, 0)
  end
end