require 'benchmark'

class AlienLanguage
  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        l, d, n = input.readline.split(' ').map { |x| x.to_i }

        dictionary = []
        1.upto(d) do |word_number|
          dictionary << input.readline
        end

        1.upto(n) do |test_case|
          regex = Regexp.new(input.readline.gsub(/[\(\)]/, '(' => '[', ')' => ']'))
          count = dictionary.select { |x| x =~ regex }.count
          output << %Q{Case ##{test_case}: #{count}\n}
        end
      end
    end
  end
end

problem = AlienLanguage.new

Benchmark.bm do |x|
  x.report('practice') { problem.solve('alien-language-practice.in') }
  x.report('small') { problem.solve('alien-language-small-practice.in') }
  x.report('large') { problem.solve('alien-language-large-practice.in') }
end