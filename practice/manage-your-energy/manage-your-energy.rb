require 'benchmark'
require 'ruby-progressbar'

class ManageYourEnergy
  def value(value, energy)
    value * energy
  end

  def backtrack(values, current_energy, depth)
    #print ' ' * depth
    #puts "#{depth}\tenergy: #{current_energy}\tgain: #{@@current_gain}\tmax_gain: #{@@max_gain}"
    @@current_gain = 0 if depth == 0

    if depth == @@n
      if @@current_gain > @@max_gain
        @@max_gain = @@current_gain
      end
    else
      0.upto(current_energy) do |energy|
        value = value(values[depth], energy)
        @@current_gain += value
        current_energy -= energy
        backtrack(values, [@@e, current_energy + @@r].min, depth + 1)
        @@current_gain -= value
        current_energy += energy
      end
    end
  end

  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        bar = ProgressBar.create :total => test_cases
        1.upto(test_cases) do |test_case|
          @@e, @@r, @@n = input.readline.split(' ').map { |x| x.to_i }
          values = input.readline.split(' ').map { |x| x.to_i }
          @@current_gain = 0
          @@max_gain = 0
          backtrack(values, @@e, 0)
          output << %Q{Case ##{test_case}: #{@@max_gain}\n}
          bar.increment
        end
      end
    end
  end
end

problem = ManageYourEnergy.new

Benchmark.bm do |x|
  x.report('practice') { problem.solve('manage-your-energy-practice.in') }
  x.report('small') { problem.solve('manage-your-energy-small-practice.in') }
  #x.report('large') { problem.solve('manage-your-energy-large-practice.in') }
end