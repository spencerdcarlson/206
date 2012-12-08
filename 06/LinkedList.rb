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

    		@head.prev.next = node
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
    	begin
    	  raise ArgumentError, "Empty LinkedList" if @size <= 0
  	    return @last.prev.data
  	    rescue
  	      puts "Empty"   		  
		  end
  	end

  	# Return the first element
  	def head
  		begin
  		  raise "Empty LinkedList" if @size <= 0
  		  return @head.data
		  rescue 
		    puts "Empty"
		  end
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
  	
  	# Remove last element *
  	def pop
      begin
        raise "Empty LinkedList" if @size <= 0
        if @size == 1 then yield @head.data; @head = nil; @last = nil  end
        if @size > 1 
      	  yield @last.prev.data
      	  node = @last.prev.prev
      	  node.next = @last.next
      	  @last.prev = node
    		  @size -= 1
  		  end
		  rescue
		    puts "Empty"
  	  end
  	end
  	
  	# Remove first element *
  	def shift
    	begin
    	  raise "Empty LinkedList"if @size <= 0
    	  if @size > 0
      	  yield @head.data
      	  node = @head.next
      	  node.prev = nil
    		  @head = node
    		  @size -= 1
  		  end
  	  rescue 
  	    puts "Empty" 
  	  end
  	end

    # Loop *
    def each
  	  begin
  	    node = @head
    		while node != @last.next
    			yield node.data unless node.data == nil
    			node = node.next
    		end
  		rescue
  		  puts "LOOPING ERROR"
		  end
  	end

  	#Loop backwards 
  	def reverse_each
  		node = @last
  		while node != nil
  		  yield node.data unless node.data == nil
  		  node = node.prev
		  end
	  end
	  
	  def self.handle (msg)
      puts msg
    end

end #LinkedList 

