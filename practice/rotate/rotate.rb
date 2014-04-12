require 'benchmark'
require 'pp'

class Rotate
  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        1.upto(test_cases) do |test_case|
          k, n = input.readline.split(' ').map { |x| x.to_i }
          board = []

          1.upto(k) do |n|
            board
          end

          output << %Q{Case ##{test_case}: #{@@mkdirs}\n}
        end
      end
    end
  end
end

problem = Rotate.new

Benchmark.bm do |x|
  x.report('practice') { problem.solve('rotate-practice.in') }
  x.report('small') { problem.solve('rotate-small-practice.in') }
  x.report('large') { problem.solve('rotate-large-practice.in') }
end