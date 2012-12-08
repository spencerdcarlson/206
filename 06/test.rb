require './LinkedList.rb'

begin
  ll = LinkedList.new 
  ll.unshift "Spencer"
  puts "unshift Spencer"
  ll.push "Paul"
  puts "push Paul"
  ll.push "Tyler"
  puts "push Tyler"
  
  ll.shift {|n| puts "shift: #{n}"}
  
  puts "Head: #{ll.head}"
  puts "Last: #{ll.last}"
  
  puts "print All: "
  ll.each {|n| puts n}
  
  ll.pop { |n| puts "poped: #{n}"}
  
  puts "print all backwards"
  ll.reverse_each { |n| puts n}
  
  Node.dump ll[0]
  
end