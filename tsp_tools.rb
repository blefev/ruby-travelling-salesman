class TSPTools
  @@rng = Random.new

  def self.generate_random_cost_matrix(size, max = 100)
    g = Graph.new(size)

    0.upto(size - 1) do |i|
      i.upto(size - 1) do |j|
        # don't add weight if same node
        next if i == j
        # generate random weight between 1..max
        g.add(i, j, @@rng.rand(1..max))
      end
    end
    g
  end


  def self.generate_random_euclidean_cost_matrix(n, max_x, max_y)
    g = Graph.new(n ** 2)

    vertice_pairs = Array.new(g.size) {
      [@@rng.rand(1..max_x), @@rng.rand(1..max_y)]
    }

    n.times do |i|
      i.upto(g.size) do |j|
        next if i == j
        (x1, y1) = vertice_pairs[i]
        (x2, y2) = vertice_pairs[j]

        distance = Math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)

        g.add(i, j, distance)
      end
    end
    g
  end


  def self.generate_random_circular_graph_cost_matrix(n, radius)
    g = Graph.new(n)

    vertice_pairs = Array.new(n)
    vertices = (0..n-1).to_a
    angle_distance = 360.0 / n
    cur_angle = 0

    vertices.each do |vertex|
      rad = cur_angle * Math::PI / 180

      x = (Math.cos(rad) * radius)
      y = (Math.sin(rad) * radius)

      vertice_pairs[vertex] = [x, y, vertex]

      cur_angle += angle_distance
    end

    vertice_pairs.shuffle!

    pair_distance = nil
    0.upto(n - 1) do |i|
      i.upto(n - 1) do |j|
        next if i == j
        (x1, y1) = vertice_pairs[i]
        (x2, y2) = vertice_pairs[j]


        distance = Math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)

        puts "Vertex pair: #{vertice_pairs[i][2]} (#{x1.round},#{y1.round}) | #{vertice_pairs[j][2]} (#{x2.round},#{y2.round})"
        puts "Distance: ~#{distance.round}\n"

        if pair_distance.nil? || distance < pair_distance
          pair_distance = distance
        end

        g.add(i, j, distance)
      end
    end

    [g, pair_distance * n]
  end
end
