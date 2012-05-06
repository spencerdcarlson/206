# PROJECT: First Order Recurrence Relations
$LOAD_PATH << '../lib'
require 'parseFile.rb'

class Forr 
  def initialize(inputs) 
    @s1 =  (inputs.has_key?('S(1)') && inputs['S(1)'] )
    @c =  (inputs.has_key?('C') && inputs['C'] )
    @gn =  (inputs.has_key?('G(N)') && inputs['G(N)'] )
    #puts s1,c,gn
    print
  end
  
  def print
    puts "S(n) = #{@c}^(n-1) * #{@s1} + sigma(#{@c}^(n-1) * #{@gn})"
    for n in 1..10 do
      i = n
      sigma = 0
      for i in 2..i do
        sigma += ( @c**(n-i) ) *@gn
      end
      puts "S(#{i}) = #{( ( @c**(n-1) ) * @s1 ) + sigma}"
    end
  end
end

begin
  parsed = Master::ParseFile.new(Hash)
  if parsed.getFile.instance_of?(Hash) then Forr.new(parsed.getFile) end
end
  