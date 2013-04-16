class T9Spelling
  @@dictionary = {
    'a' => 2,
    'b' => 22,
    'c' => 222,
    'd' => 3,
    'e' => 33,
    'f' => 333,
    'g' => 4,
    'h' => 44,
    'i' => 444,
    'j' => 5,
    'k' => 55,
    'l' => 555,
    'm' => 6,
    'n' => 66,
    'o' => 666,
    'p' => 7,
    'q' => 77,
    'r' => 777,
    's' => 7777,
    't' => 8,
    'u' => 88,
    'v' => 888,
    'w' => 9,
    'x' => 99,
    'y' => 999,
    'z' => 9999,
    ' ' => 0
  }

  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        1.upto(test_cases) do |test_case|
          output << %Q{Case ##{test_case}: }
          last_button = -1
          input.readline.each_char do |c|
            break if c == "\n"
            t9 = @@dictionary[c]
            new_button = t9 % 10
            output << " " if new_button == last_button
            output << t9
            last_button = new_button
          end
          output << "\n"
        end
      end
    end
  end
end

problem = T9Spelling.new
problem.solve('t9-spelling-practice.in')
problem.solve('t9-spelling-small-practice.in')
problem.solve('t9-spelling-large-practice.in')
