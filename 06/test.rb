require './LinkedList.rb'

begin
  ll = LinkedList.new 
  ll.unshift "Spencer"
  ll.push "Paul"
  ll.push "Tyler"
  
  #ll.shift {|n| puts n}
  
  puts "Head: #{ll.head}"
  puts "Last: #{ll.last}"
  ll.each {|n| puts n}
  Node.dump ll[2]
  
end