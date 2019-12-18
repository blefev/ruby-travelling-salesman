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



  def dp3
    # let's get it right this time
    #

    n = @graph.size
puts n
    # first index will be int
    # second index will be a set represented by an int
    costs = {}

    home = 0

    (1..n - 1).each do |k|
      k_bits = 1 << k
      costs[k] = {}
      costs[k][k_bits] = @graph.get(home, k)
    end


    (2..n).each do |subset_size|
      # iterate subsets represented as bits
      (1..n).to_a.combination(subset_size).each do |subset|
        bits = 0
        p subset
        subset.each do |bit|
          bits |= 1 << bit
        end

        puts bits.to_s(2)

        subset.each do |k|
          prev = bits & ~(1 << k)

          res = []

          subset.each do |m|
            next if m == 0 or m == k
            costs[m][prev] = {} if costs[m][prev].nil?
            res << costs[m][prev] + @graph.get(m, k)
          end

          costs[k][bits] = res.min

          puts res
        end
      end

    end
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