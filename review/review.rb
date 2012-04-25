# Add sum, mean, & median to Array class
class Array; def sum; inject(:+) end end
class Array; def mean; sum.to_f / size end end
class Array
  def median(arry) 
    sorted = arry.sort
    medpt = arry.length / 2
    medpt1 = ( ( arry.length - 1 ).to_f / 2 )
    (sorted[medpt] + sorted[medpt1]).to_f / 2
  end
end
def empty
  puts "Sum: 0.0"
  puts "Mean: 0.0"
  puts "Median 0.0"
  exit
end

begin
# Get file from cmd :: Default file is input1.txt
if ARGV[0] != nil; input = ARGV[0] else input = "input1.txt" end

#Read in a file
file = File.new(input, 'r')

# check file size
if File.size(input) <= 0; empty end

#Parse file  
nums = Array.new
while (line = file.gets)
  num = line.split(" ")
  num.length.times do |n|
    nums.push(Float(num[n]))
  end
end
rescue Errno::ENOENT
   puts "The file was not found: #{$!}"
   exit
ensure
  file.close if file
end

#Print out sum,mean & median
puts "Sum: #{sprintf("%.2f", nums.sum)}"
puts "Mean: #{sprintf("%.2f",nums.mean)}"
puts "Median: #{sprintf("%.2f",nums.median(nums) )}"




