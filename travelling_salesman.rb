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


  def arr_to_b(array)
    array.reduce(0) { |a,x| a | 2**(x-1) }
  end

  def b_to_arr(num)
    num.to_s(2).chars.reverse.each_with_index.map do |x, pos|
      x == "1" ? pos + 1 : 0
    end
  end


  def dp
    costs = Array.new(@graph.size, Hash.new)
    n = @graph.size

    (1..n-1).each do |k|
      bin_k = arr_to_b([n])
      costs[k][arr_to_b([k])] = @graph.get(0, k)
    end

    (2..n-1).each do |s|
      if s == n-1
        puts "hiya!"
      end
      (1..n-1).to_a.combination(s) do |subset|
        subset.each do |k|
          bin_subset = arr_to_b(subset)

          # find minimum m not  k, m in S Cost plus distance
          # for every m in S-k
          subset_sans_k = subset.reject{|x| x == k}
          bin_ssk = arr_to_b(subset_sans_k)

          costs[k][bin_subset] = subset_sans_k.min do |m1, m2|
            costs[m1][bin_ssk] + @graph.get(m1, k) <=> costs[m2][bin_ssk] + @graph.get(m2, k)
          end
        end
      end
    end

    bin_full_tour = arr_to_b(1..n-1)
    (1..n-1).to_a.min do |k1, k2|
      costs[k1][bin_full_tour] + @graph.get(0, k1) <=> costs[k2][bin_full_tour] + @graph.get(0, k2)
    end
  end





#
# cost_table: 2d array of vertex and tour
#
#
  def dp_rec(tour, c, cost_table)


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