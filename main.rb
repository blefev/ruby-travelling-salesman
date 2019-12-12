require_relative "./graph.rb"

def main
  g = Graph.new(10)
  g.add(0,1,2)
  puts g.get(0,1)
end

main