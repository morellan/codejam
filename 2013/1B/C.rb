require 'benchmark'
require 'ruby-progressbar'

class C
  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        bar = ProgressBar.create :total => test_cases
        1.upto(test_cases) do |test_case|
          # other inputs
          r, t = input.readline.split(' ').map { |x| x.to_i }

          # solve
          circles = black_circles(r, t)

          # output
          output << %Q{Case ##{test_case}: #{circles}\n}
          bar.increment
        end
      end
    end
  end
end

problem = C.new

Benchmark.bm do |x|
  x.report('practice') { problem.solve('C-practice.in') }
  x.report('small') { problem.solve('C-small-practice.in') }
  x.report('large') { problem.solve('C-large-practice.in') }
end