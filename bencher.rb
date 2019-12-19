require 'benchmark'

class Bencher
  def initialize(max_inputs, trials = 4)
    @max_inputs = max_inputs
    @trials = trials
  end

  def bench(name)
    unless Dir.exists? "output"
      Dir.mkdir "output"
    end

    File.open("output/" + name, 'w') { |f| f.truncate(0) }

    #f.puts "n\tTime"
    puts "n\tTime"

    prev = 0

    2.upto(@max_inputs[name]) do |n|
      puts "Trial with Input #{n}"
      sum = 0


      @trials.times.map do
        print "."

        lambda = yield n

        # benchmark the time it takes to perform funciton
        bm = Benchmark.realtime do |b|
          lambda.call
        end

        sum += bm
      end
      puts

      avg = sum / @trials

      if prev != 0
        dbl_ratio = avg / prev
        #puts "Doubling time: #{dbl_ratio}"
        #puts
      end

      File.open("output/" + name, 'a') { |f| f.puts("#{n}\t#{avg}\t#{dbl_ratio}") }
      #puts("#{n},\t#{avg}\t#{dbl_ratio},")

      prev = avg

    end
  end
end