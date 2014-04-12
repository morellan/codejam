class Problem
  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        1.upto(test_cases) do |test_case|

          response = "PROFIT!"

          output << %Q{Case ##{test_case}: #{response}\n}
        end
      end
    end
  end
end

problem = Problem.new
#problem.solve('A.in')
#problem.solve('A-small-attempt0.in')
#problem.solve('A-large.in')
