class ChargingChaos
  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        1.upto(test_cases) do |test_case|
          n, l = input.readline.split(' ').map { |s| s.to_i }
          
          outlets = input.readline.split
          devices = input.readline.split.sort
  
          response = -1
          movements = 0

          (0..l-1).each do |switch|
            outlets = outlets.sort
            puts "Outlets (#{switch}): " + outlets.inspect
            puts "Devices (#{switch}): " + devices.inspect

            if outlets.eql? devices
              response = movements
              break
            else
              # change_switch(outlets, devices)
              (0..l-1).each do |i|
                next if outlets[i].eql? devices[i]
                (0..l-1).each do |j|
                  next if outlets[i][j] == devices[i][j]
                  outlets = outlets.map do |s|
                    s[j] = (s[j] == "0") ? "1" : "0"
                    s
                  end
                  movements = movements + 1
                  break
                end
                break
              end
            end
          end

          response = "NOT POSSIBLE" if response < 0

          output << %Q{Case ##{test_case}: #{response}\n}
        end
      end
    end
  end
end

problem = ChargingChaos.new
problem.solve('A.in')
problem.solve('A-small-practice.in')
#problem.solve('A-large.in')
