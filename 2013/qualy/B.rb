class Lanmower
  def solve(input)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        1.upto(test_cases) do |test_case|
          n, m = input.readline.split(' ').map { |s| s.to_i }
          board = []

          1.upto(n) do |idx|
            board[idx] = input.readline.split(' ').map { |s| s.to_i }
          end

          1.

          output << %Q{Case ##{test_case}: #{cart.join(" ")}\n}
        end
      end
    end
  end
end

problem = StoreCredit.new
problem.solve('B.in')
#problem.solve('B-large-practice.in')
