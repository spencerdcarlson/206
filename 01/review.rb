# PROJECT: CODEING REVIEW

# Global Variables 
$EmptyFile = false
$nums = Array.new

# Get file from cmd :: Default file is input1.txt
input = ( ARGV[0] && ARGV[0] ) || 'input1.txt'

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

#Print out sum,mean & median
def printAll
  if $EmptyFile
    puts "Sum: 0.0"
    puts "Mean: 0.0"
    puts "Median 0.0"
    exit
  else
    puts "Sum: #{sprintf("%.2f", $nums.sum)}"
    puts "Mean: #{sprintf("%.2f",$nums.mean)}"
    puts "Median: #{sprintf("%.2f",$nums.median($nums) )}" 
    exit 
  end 
end

begin  
  # check file size & Read in a file
  if File.size(input) <= 0; $EmptyFile = true else
    file = File.new( input, 'r') 
  
    #Parse file  
    while (line = file.gets)
      num = line.split(" ")
      num.length.times do |n|
        $nums.push(Float(num[n]))
      end
    end
  end
  
  rescue Errno::ENOENT
    puts "\nFile not found: #{$!}"
    puts 'Please specify another file or type \'q\' to quit'
    input = $stdin.gets.chomp
    if input.casecmp('q') == 0; exit else retry end
  ensure
    file.close if file
end

printAll











