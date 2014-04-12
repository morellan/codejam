require 'benchmark'
require 'ruby-progressbar'

class A
  def make_moves(a, sizes)
    while true
      max_less = sizes.index { |x| x < a }
      break if not max_less
      pre_a = a
      a += sizes[max_less..-1].inject {|sum, x| sum + x }
      puts "make_moves: #{max_less}, #{a}, #{sizes}"
      sizes.delete_if { |x| x < pre_a }
    end

    [a, sizes]
  end

  def try_add_remove(min, max, a, sizes)
    puts "try_add_remove: #{min}, #{max}, #{a}, #{sizes}"
    best_moves = max
    while min < max
      [true, false].each do |remove_one|
        if remove_one
          puts "(#{min}) trying to remove the max"
          a, new_sizes = make_moves(a, sizes[1..-1])
        else
          puts "(#{min}) trying to add a - 1"
          sizes << a - 1
          a, new_sizes = make_moves(a, sizes)
        end

        if sizes.count.zero?
          best_moves = min
        else
          best_moves = try_add_remove(min + 1, max, a, new_sizes)
        end
      end
      min += 1
      break if best_moves < max
    end

    best_moves
  end

  def min_movements(a, sizes)
    a, sizes = make_moves(a, sizes)

    max = sizes.count
    if max.zero?
      max
    else
      moves = try_add_remove(1, max, a, sizes)
      [max, moves].min
    end
  end

  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        bar = ProgressBar.create :total => test_cases
        1.upto(test_cases) do |test_case|
          # other inputs
          a, n = input.readline.split(' ').map { |x| x.to_i }
          sizes = input.readline.split(' ').map { |x| x.to_i }.sort

          # solve
          #min = min_movements(a, sizes.sort.reverse)
          # Solucion flaite
          best = n
          moves = 0
          if a == 1
            moves = n
          else
            0.upto(sizes.count - 1) do |idx|
              if sizes[idx] < a
                a += sizes[idx]
              else
                best = [best, moves + n - idx].min
                while a <= sizes[idx]
                  a += a - 1
                  moves += 1
                end
                a += sizes[idx]
              end
            end
          end

          best = [best, moves].min

          # output
          output << %Q{Case ##{test_case}: #{best}\n}
          bar.increment
        end
      end
    end
  end
end

problem = A.new

Benchmark.bm do |x|
  x.report('practice') { problem.solve('A-practice.in') }
  x.report('small') { problem.solve('A-small-practice.in') }
  x.report('large') { problem.solve('A-large-practice.in') }
end