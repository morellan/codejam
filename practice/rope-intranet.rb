require 'benchmark'

class RopeIntranet
  def check_intersections(wire, set)
    left, right = wire
    set.select { |x, y| (x > left and y < right) or (x < left and y > right) }.count
  end

  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i

        1.upto(test_cases) do |test_case|
          wires = input.readline.to_i
          wires_set = []
          intersections = 0

          1.upto(wires) do
            new_wire = input.readline.split(' ').map { |x| x.to_i }
            intersections += check_intersections(new_wire, wires_set)
            wires_set << new_wire
          end

          output << %Q{Case ##{test_case}: #{intersections}\n}
        end
      end
    end
  end
end

problem = RopeIntranet.new

Benchmark.bm do |x|
  x.report('practice') { problem.solve('rope-intranet-practice.in') }
  x.report('small') { problem.solve('rope-intranet-small-practice.in') }
  x.report('large') { problem.solve('rope-intranet-large-practice.in') }
end