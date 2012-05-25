class Node
  attr_accessor :data
  attr_accessor :nextItem
  
  def Initialize(d)
    @data = d
    @nextItem
  end 
  
end

class LinkedList
  attr_accessor :head
  
  def initialize()
    @head
  end
  
  def add(i)
    #If head == null set new node as head
    @head ||= Node.new(i)
    # if Head != null set new node to the end
    if @head
      current = @head
      while current.nextItem
        current = current.nextItem
      end
      current.nextItem = Node.new(i)  
    end
  end #add
  
  def printAll
    current = @head
    if current
      puts current
      current = ( current && current.nextItem ) || nil
    end
  end
  
end #LinkedList 


class Main

  begin
  @lnl = LinkedList.new()
  @lnl.add("Hello")
  @lnl.add("WORLD")
  @lnl.add("THANKS")
  @lnl.printAll
  
  end

end