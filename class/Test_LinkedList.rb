require './LinkedList.rb'

begin
 @ll = LinkedList.new
 @ll.unshift "Tom"
 @ll.push "Spencer"
 @ll.push "Geffory"
 @ll.each {|n| puts n}
 @ll.shift
 @ll.shift
 @ll.shift
 @ll.shift
 @ll.push "THANKS"
 @ll.each {|n| puts n }
end