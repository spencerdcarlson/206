# http://www.koders.com/ruby/fidCB5A463AB556F4FFD20E03139FF59563B118D108.aspx
class Node
	
	attr_reader :object
	attr_reader :prev
	attr_reader :next
	
	attr_writer :next
	attr_writer :prev

	def initialize(object)
		@object = object
	end

	def self.dump(node)
		puts "===== #{self} ====="
		puts "Object: #{node.object}"
		puts "Prev: #{node.prev.object}"
		puts "Next: #{node.next.object}"
	end
end

class LinkedList

	include Enumerable

	def initialize
		@first = Node.new nil
		@last = Node.new nil

		@first.next = @last
		@last.prev = @first
		@size = 0
	end

	# Add item to end index: -1
	def push(object)
		node = Node.new(object)
		node.next = @last
		node.prev = @last.prev
		
		@last.prev.next = node
		@last.prev = node
		@size += 1
	end

	# Add item to front index: 0
	def unshift(object)
		node = Node.new(object)
		node.prev = @first
		node.next = @first.next
		
		@first.next.prev = node
		@first.next = node
		@size += 1
	end

	
	def last
		raise "No objects in list" if @size <= 0
		return @last.prev.object
		rescue Exception => e
	    handle_exception e
	end

	# Get head
	def first
		raise "No objects in list" if @size <= 0
		return @first.next.object
		rescue Exception => e
	    handle_exception e
	end

	# Remove last item
	def pop
		raise "Empty list" if @size <= 0
		node = @last.prev
		node.prev.next = @last
		@last.prev = node.prev
		@size -= 1
		return node.object
		rescue Exception => e
	    handle_exception e
	end

	# Remove first item
	def shift
		raise "Empty List" if @size <= 0
		node = @first.next
		node.next.prev = @first
		@first.next = node.next
		@size -= 1
		return node.object
		rescue Exception => e
	    handle_exception e
	end
  
  # Get LinkedList size
	def size
		return @size
	end

	def each
		raise "Empty List" if @size <= 0
		node = @first.next
		while node != @last
			yield node.object
			node = node.next
		end
	rescue Exception => e
	  handle_exception e
	end

	def reverse_each
		node = @last.prev
		while node != @first
		  yield node.object 
		  node = node.prev
	  end
	end
	
	# get node objects
  def [](index)
    item = 0
    if index >= 0
      node = @first.next
  		while node != @last
  			if item == index 
  			  return node
  		  else
  			  node = node.next
  			  item += 1
  		  end
		  end
		else
	    node = @last.prev
	    item -= 1
	    while node != @first
	      if item == index
	        return node
        else
	        node = node.prev
	        item -= 1
        end
      end
    end
		 raise "Out of Bounds Size: #{@size}" if (index).abs + 1 > @size
	 rescue Exception => e
	   handle_exception(e)
  end
  
  def handle_exception (e)
    puts "\e[5;34m#{e}\e[0m"
  end

end