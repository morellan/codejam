class TheRepeater
  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        1.upto(test_cases) do |test_case|

          n = input.readline.to_i
          strings = {}
          chars = []
          max = {}
          no_good = false

          1.upto(n) do |i|
            hash = {}
            input.readline.strip.each_char do |c|
              chars << c if chars[chars.length - 1] and chars[chars.length - 1] != c
              hash[c] = hash[c] ? hash[c] + 1 : 1
            end

            if not chars.empty?
              if not chars.eql?(hash.keys.sort)
                no_good = true
                break
              end
            else
              chars = hash.keys.sort
            end

            chars.each do |c|
              if max[c]
                max[c] = [max[c], hash[c]].max
              else
                max[c] = hash[c]
              end
            end

            strings[i] = hash
          end

          #puts "Max: " + max.inspect
          #puts "Strings: " + strings.inspect

          if no_good
            #puts " - NO GOOD - "
            response = "Fegla Won"
          else
            response = 0
            strings.each do |i, s|
              chars.each do |c|
                #puts "response: #{response}, max[#{c}] = #{max[c]}, s[#{c}] = #{s[c]}, "
                response = response + (max[c] - s[c]).to_i
              end
            end
          end

          output << %Q{Case ##{test_case}: #{response}\n}
        end
      end
    end
  end
end

problem = TheRepeater.new
problem.solve('A.in')
problem.solve('A-small-attempt0.in')
#problem.solve('A-large.in')
