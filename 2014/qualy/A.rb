class MagicTrick
  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        1.upto(test_cases) do |test_case|

          answer = input.readline.to_i

          # skip (answer - 1) lines
          (answer - 1).times { input.readline }
          # read the specific line
          cards1 = input.readline.split(' ').map { |s| s.to_i }
          # skip the remaining lines
          (4 - answer).times { input.readline }

          answer = input.readline.to_i

          # skip (answer - 1) lines
          (answer - 1).times { input.readline }
          # read the specific line
          cards2 = input.readline.split(' ').map { |s| s.to_i }
          # skip the remaining lines
          (4 - answer).times { input.readline }

          magic = cards1 & cards2
          result = magic.length
          
          if result > 1
            response = "Bad magician!"
          elsif result == 1
            response = magic.pop
          else
            response = "Volunteer cheated!"
          end


          output << %Q{Case ##{test_case}: #{response}\n}
        end
      end
    end
  end
end

problem = MagicTrick.new
problem.solve('A.in')
problem.solve('A-small-attempt0.in')
#problem.solve('B-large-practice.in')
