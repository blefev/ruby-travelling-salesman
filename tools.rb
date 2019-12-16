class Tools
  @@rng = Random.new

  def generate_random_cost_matrix(size, max=10)
    g = Graph.new(size)

    0.upto(size-1) do |i|
      i.upto(size-1) do |j|
        # don't add weight if same node
        next if i == j
        # generate random weight between 1..100
        g.add(i, j, @@rng.rand(1..max))
      end
    end
    g
  end



  def generate_random_euclidean_cost_matrix(n, max_x, max_y)
    g = Graph.new(n**2)

    vertice_pairs =  Array.new(g.size) {
          [@@rng.rand(1..max_x, @@rng.rand(1..max_y)]
        }

    n.times do |i|
      i.upto(g.size) do |j|
        next if i == j
        ((x1, y1), (x2, y2)) = (vertice_pairs[i], vertice_pairs[j])

        distance = Math.sqrt( (x2 - x2)**2 + (y2 - y1)**2)

        g.add(i, j, distance)
      end
    end
    g
  end



  def generate_random_circular_graph_cost_matrix(n, radius)
    g = Graph.new(n**2)

    vertice_pairs =  Array.new(g.size)

    vertices = (1..n).to_a.shuffle
    circumference = 2 * Math::PI * radius

    angle_distance = 360 / n

    cur_angle = 0


    vertices.each do |vertex|
      rad = cur_angle * Math::PI / 180
      x = Math.cos(rad) * radius
      y = Math.sin(rad) * radius
      vertice_pairs = [x, y]
      cur_angle += angle_distance
    end

    n.times do |i|
      i.upto(g.size) do |j|
        next if i == j
        ((x1, y1), (x2, y2)) = (vertice_pairs[i], vertice_pairs[j])

        distance = Math.sqrt( (x2 - x2)**2 + (y2 - y1)**2)

        g.add(i, j, distance)
      end
    end
  end
end
