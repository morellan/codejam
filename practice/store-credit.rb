require 'benchmark'

class StoreCredit
  def shop(credit, prices)
    sorted_prices = prices.select { |x| x < credit }.sort { |y, x| x <=> y }
    sorted_count = sorted_prices.count - 1
    solution_found = false
    head = 0
    tail = 0
    0.upto(sorted_count) do |i|
      head = sorted_prices[i]
      sorted_count.downto(0) do |j|
        tail = sorted_prices[j]
        if head + tail == credit
          solution_found = true
          break
        end
      end
      break if solution_found
    end
    [prices.index(head) + 1, prices.rindex(tail) + 1].sort
  end

  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        1.upto(test_cases) do |test_case|
          credit = input.readline.to_i
          items = input.readline.to_i
          prices = input.readline.split(' ').map { |x| x.to_i }
          result = shop(credit, prices)
          output << %Q{Case ##{test_case}: #{result.join(' ')}\n}
        end
      end
    end
  end
end

problem = StoreCredit.new

Benchmark.bm do |x|
  x.report('practice') { problem.solve('store-credit-practice.in') }
  x.report('small') { problem.solve('store-credit-small-practice.in') }
  x.report('large') { problem.solve('store-credit-large-practice.in') }
end