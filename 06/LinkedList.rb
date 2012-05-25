class Node
  
		attr_reader :data
		attr_reader :prev
		attr_reader :next
		
		attr_writer :next
		attr_writer :prev

		def initialize(data)
			@data = data
		end

		def self.dump(node)
			puts "===== #{self} ====="    
			puts "Data: #{node.data}"     if node.data
			puts "Prev: #{node.prev.data}"  if node.prev
			puts "Next: #{node.next.data}"  if node.next
		end
end
	

class LinkedList

  
  include Enumerable

  	def initialize(data = nil)
  		if data
  		  @head = Node.new data
  		  @last = Node.new nil
  		  
  		  @head.next = @last
  		  @last.prev = @head
  		  @size = 1
		  else		
  		  @size = 0
		  end
  	end
  	
    # Add as first element *
    def unshift(data)
    	unless @head
    	  initialize data
    	else
    	  node = Node.new(data)
      	node.prev = nil
    		node.next = @head

    		@head = node
    		@size += 1
    		nil
  		end
    end
    
    # Add as last element *
    def push(data)
    	unless @head
    	  initialize data
  	  else
      	node = Node.new(data)
    		node.next = @last
    		node.prev = @last.prev
    		@last.prev.next = node
    		@last.prev = node
    		@size += 1
    		nil
  		end
    end
    
    # Return the last element
    def last
    	raise "Empty LinkedList" if @size <= 0
  		return @last.prev.data
  	end

  	# Return the first element
  	def head
  		raise "Empty LinkedList" if @size <= 0
  		return @head.data
  	end
  	
  	# Get size
  	def size
      @size
    end
    
    # get node objects
    def [](ind)
      node = @head
      item = 0
  		while node != @last
  			if item == ind 
  			  return node
			  else
  			  node = node.next
  			  item += 1
			  end
  		end
  		 raise "Index out of Bounds" if ind > item
    end
  	
  	# Remove last element *** FIX ME  ****
  	def pop
      #raise "Empty LinkedList" if @size <= 0
      puts "Empty" if @size <= 0
    	if @size > 0 
    	  node = @last.prev
  		  node.prev.next = @last
  		  @last.prev = node.prev
  		  @size -= 1
  		  yield node.data
  		  return node.data
		  end
  	end
  	
  	# Remove first element *** FIX ME  ****
  	def shift
    	#raise "Empty LinkedList"if @size <= 0
    	puts "Empty" if @size <= 0
  	  if @size > 0
    	  node = @head.next
  		  node.next.prev = @head
  		  @head.next = node.next
  		  @size -= 1
  		  yield node.data
  		  return node.data
		  end
  	end

    # Loop *
    def each
  	  node = @head
  		while node != @last
  			yield node.data
  			node = node.next
  		end
  	end

  	#Loop backwards 
  	def reverse_each
  		node = @last
  		while node != nil
  		  yield node.data
  		  node = node.prev
		  end
	  end

end #LinkedList 

