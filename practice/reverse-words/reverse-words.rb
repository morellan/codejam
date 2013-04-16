class ReverseWords
  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        1.upto(test_cases) do |test_case|
          output << %Q{Case ##{test_case}: #{input.readline.split(" ").reverse.join(" ")}\n}
        end
      end
    end
  end
end

problem = ReverseWords.new
problem.solve('reverse-words-practice.in')
problem.solve('reverse-words-small-practice.in')
problem.solve('reverse-words-large-practice.in')
#problem.solve('B-large-practice.in')
