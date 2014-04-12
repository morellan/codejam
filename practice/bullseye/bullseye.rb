require 'benchmark'
require 'ruby-progressbar'

class Bullseye
  def black_circles_sum(radius, circles)
    # Given: http://www.wolframalpha.com/input/?i=sum+%28r+%2B+2n+-1%29%5E2+-+%28r+%2B+2n+-+2%29%5E2
    # Then: http://www.wolframalpha.com/input/?i=sum+4n+%2B+2r+-+3+for+n
    circles * (2 * circles + 2 * radius - 1)
  end

  def black_circles(radius, total_paint)
    # Given: http://www.wolframalpha.com/input/?i=solve+0+%3D+2i%5E2+%2B+%282r+-1%29i+-+t+for+i
    # circles math solution: ((Math.sqrt(4 * radius ** 2 - 4 * radius + 8 * total_paint + 1) - 2 * radius + 1) / 4).floor

    best_circles = (Math.sqrt(4 * radius ** 2 - 4 * radius + 8 * total_paint + 1) - 2 * radius + 1) / 4

    circles = [(best_circles - 10).floor, 1].max
    while black_circles_sum(radius, circles) <= total_paint
      circles += 1
    end
    circles - 1

    # left, right = 0, total_paint
    # while left < right
    #   center = (left + right) / 2
    #   sum = black_circles_sum(radius, center)
    #   puts "l: #{left}\tr: #{right}\tc: #{center}\tsum: #{sum}"
    #   if sum >= total_paint
    #     #center -= 1 if right == center
    #     right = center - 1
    #   else
    #     center += 1 if left == center
    #     left = center
    #   end
    # end
    # left
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