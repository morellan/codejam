require 'benchmark'

class Bullseye
  def black_circles(radius, total_paint)
    circles = 0

    while true
      paint = 2 * radius + 4 * (circles + 1) - 3
      if paint <= total_paint
        circles += 1
        total_paint -= paint
      else
        break
      end
    end

    circles
  end

  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        1.upto(test_cases) do |test_case|
          r, t = input.readline.split(' ').map { |x| x.to_i }

          circles = black_circles(r, t)

          output << %Q{Case ##{test_case}: #{circles}\n}
        end
      end
    end
  end
end

problem = Bullseye.new

Benchmark.bm do |x|
  x.report('practice') { problem.solve('bullseye-practice.in') }
  x.report('small') { problem.solve('bullseye-small-practice.in') }
  #x.report('large') { problem.solve('bullseye-large-practice.in') }
end