require 'benchmark'

class MinimumScalarProduct
  def mvp(vector1, vector2)
    vector1.zip(vector2).map { |x, y| x * y }.inject(0) { |sum, number| sum + number }
  end

  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        1.upto(test_cases) do |test_case|
          length = input.readline.to_i
          vector1 = input.readline.split(' ').map { |x| x.to_i }
          vector2 = input.readline.split(' ').map { |x| x.to_i }

          min = [
            mvp(vector1.sort { |x, y| x <=> y }, vector2.sort { |y, x| x <=> y }),
            mvp(vector2.sort { |x, y| x <=> y }, vector1.sort { |y, x| x <=> y })
          ].min

          output << %Q{Case ##{test_case}: #{min}\n}
        end
      end
    end
  end
end

problem = MinimumScalarProduct.new

Benchmark.bm do |x|
  x.report('practice') { problem.solve('minimum-scalar-product-practice.in') }
  x.report('small') { problem.solve('minimum-scalar-product-small-practice.in') }
  x.report('large') { problem.solve('minimum-scalar-product-large-practice.in') }
end