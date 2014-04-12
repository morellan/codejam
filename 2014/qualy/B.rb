class CookieClick
  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        1.upto(test_cases) do |test_case|

          c, f, x = input.readline.split(' ').map { |s| s.to_f }

          min = x / 2

          i = 0
          sum = 0
          while 1
            c_calc = c / (2 + i * f)

            x_calc = x / (2 + (i + 1) * f)

            break if sum + c_calc + x_calc >= min

            #puts "Cookie farm #{i + 1} for #{c_calc} s + #{x_calc} s or #{sum}"

            sum += c_calc
            min = sum + x_calc
            i = i + 1
          end


          output << %Q{Case ##{test_case}: #{min.round(7)}\n}
        end
      end
    end
  end
end

problem = CookieClick.new
problem.solve('B.in')
problem.solve('B-small-attempt0.in')
problem.solve('B-large.in')
