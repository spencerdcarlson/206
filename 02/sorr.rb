# PROJECT: SECOND ORDER RECURRENCE RELATIONS
$LOAD_PATH << '../lib'
require 'parseFile.rb'

class Sorr
  
  def initialize(inputs)
    s1 = inputs["S(1)"];  s2 = inputs["S(2)"]
    c1 = inputs['C1'];    c2 = inputs['C2']
r1,r2 = quadratic(c1,c2)
    
    puts "r1 = #{r1}"
    puts "r2 = #{r2}"
    
    unless r1 == r2
      q = ((s2 - (s1 * r1) ) / ( ( -r1 ) + r2 ))
      p = s1 - q
      puts "p = #{p}"
      puts "q = #{q}"
      puts "S(n) = (#{p})(#{r1})^(n-1) + (#{q})(#{r2})^(n-1)"
      for i in 1..10 do
        puts "S(#{i}) = #{(p*r1**(i-1) + q*r2**(i-1))}"  
      end      
    else
      
    end #unless
  end #initialize
  
  def quadratic(b,c)
     [ ( b + Math.sqrt(b**2 + 4 * c) ) / 2,
     ( b - Math.sqrt(b**2 + 4 * c) ) / 2 ]   
  end #quadratic
end #class Sorr



begin
  fileName = ( ARGV[0] && ARGV[0] ) || '../01/input1.txt'
  file = File.new( fileName, 'r')
  
  parsed = Master::ParseFile.new(file, Float)
  if parsed.getFile.is_a?(Hash) then Sorr.new(parsed.getFile) end
  
  
  rescue Errno::ENOENT
    puts "\nFile not found: #{$!}"
    puts 'Please specify another file or type \'q\' to quit'
    input = $stdin.gets.chomp
    if input.casecmp('q') == 0; exit else fileName = input; retry end
  ensure
    file.close if file
end





