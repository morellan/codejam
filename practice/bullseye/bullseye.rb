require 'benchmark'
require 'ruby-progressbar'

class Bullseye
  def black_circles(radius, total_paint)
    # Given: http://www.wolframalpha.com/input/?i=sum+%28r+%2B+2n+-1%29%5E2+-+%28r+%2B+2n+-+2%29%5E2
    # Then: http://www.wolframalpha.com/input/?i=solve+0+%3D+2i%5E2+%2B+%282r+-1%29i+-+t+for+i
    ((Math.sqrt(4 * radius ** 2 - 4 * radius + 8 * total_paint + 1) - 2 * radius + 1) / 4).floor
  end

  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        bar = ProgressBar.create :total => test_cases
        1.upto(test_cases) do |test_case|
          r, t = input.readline.split(' ').map { |x| x.to_i }

          circles = black_circles(r, t)

          output << %Q{Case ##{test_case}: #{circles}\n}
          bar.increment
        end
      end
    end
  end
end

problem = Bullseye.new

Benchmark.bm do |x|
  x.report('practice') { problem.solve('bullseye-practice.in') }
  x.report('small') { problem.solve('bullseye-small-practice.in') }
  x.report('large') { problem.solve('bullseye-large-practice.in') }
end