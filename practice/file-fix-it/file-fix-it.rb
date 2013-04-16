require 'benchmark'
require 'pp'

class FileFixIt
  @@mkdirs = 0

  def makedirs(directory_tree, new_dir_path)
    dir = new_dir_path.shift
    #pp directory_tree
    #puts " testing dir = #{dir}"
    if not directory_tree.has_key?(dir)
      #puts "   #{dir} doesn't exist"
      directory_tree[dir] = {}
      @@mkdirs += 1
    end

    if new_dir_path.count > 0
      directory_tree[dir] = makedirs(directory_tree[dir], new_dir_path)
    end

    directory_tree
  end

  def solve(dataset)
    File.open(dataset, 'r') do |input|
      File.open(dataset.sub(/\.in/, '.out'), 'w') do |output|
        test_cases = input.readline.to_i
        1.upto(test_cases) do |test_case|
          n, m = input.readline.split(' ').map { |x| x.to_i }
          tree = {}

          @@mkdirs = 0
          # build directory tree
          1.upto(n) do
            tree = makedirs(tree, input.readline.gsub(/^\/|\n$/, '').split('/'))
          end
          #puts "mkdirs in building tree: #{@@mkdirs}"

          # test each new directory
          @@mkdirs = 0
          1.upto(m) do
            #pp tree
            tree = makedirs(tree, input.readline.gsub(/^\/|\n$/, '').split('/'))
          end
          #pp tree
          #puts "mkdirs testing new tree: #{@@mkdirs}"

          output << %Q{Case ##{test_case}: #{@@mkdirs}\n}
        end
      end
    end
  end
end

problem = FileFixIt.new

Benchmark.bm do |x|
  x.report('practice') { problem.solve('file-fix-it-practice.in') }
  x.report('small') { problem.solve('file-fix-it-small-practice.in') }
  x.report('large') { problem.solve('file-fix-it-large-practice.in') }
end