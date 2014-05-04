class NewLotteryGame
  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        1.upto(test_cases) do |test_case|

          a, b, k = input.readline.split.map(&:to_i)

          #puts "A: #{a}, B: #{b}, K: #{k} = #{a & b}"

          chances = 0
          0.upto(a - 1) do |a_i|
            0.upto(b - 1) do |b_i|
              bit = a_i & b_i
              #puts "(#{a_i}, #{b_i}): #{a_i} & #{b_i} = #{bit}"
              if bit >= 0 and bit < k
                chances = chances + 1
              end
            end
          end

          response = chances

          output << %Q{Case ##{test_case}: #{response}\n}
        end
      end
    end
  end
end

problem = NewLotteryGame.new
#problem.solve('B.in')
#problem.solve('B-small-attempt0.in')
problem.solve('B-large.in')
