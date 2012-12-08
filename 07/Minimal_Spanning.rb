require 'awesome_print'


class Graph_Traversal
  
  def initialize(start, pairs)
    @start_node = start
    @pairs = pairs
    @visited = Array.new 
    @possible = Array.new 
    nodes_and_arcs pairs
    min_spanning
    
  end
  
  def nodes_and_arcs (items)
    items.each do |key,value| 
      print "#{key}: "
      value.each {|i| print "#{ i.keys.join (" ") } "}
      puts
    end
  end
  
  def min_spanning
    @visited << @start_node
    puts
    puts "Minimal Spanning Tree: "
    print "#{@start_node}"
    node = @start_node
    while (@visited.size < @pairs.size  )
        node = smallest_node ( @pairs[node] )
        print " #{node}"
    end
    puts    
    #puts "VISTED: #{@visited}"
    #puts "POSSIBLE: #{@possible}"
  end
  
  # retrun smallest node
  def smallest_node (array_of_hashes)
    keys = Array.new
    for i in 0..array_of_hashes.size-1 do
      keys << array_of_hashes[i].keys[0] if array_of_hashes[i].values[0] == false
    end
    
    # add all the new keys to possible nodes to visit
    @possible << keys
    @possible.flatten!
    @possible = @possible.uniq
    @possible = @possible - @visited
    
    # get the next node to switch to true
    switchNode = keys[keys.index keys.min]
    # index of the hash which contains the next node to visit
    index = keys.index keys.min
    # Set visited to True
    array_of_hashes[index][switchNode] = true
    # Set nextNode as Visited
    nextNode = @possible[@possible.index @possible.min] if @possible.size > 0
    @visited << nextNode 
    return nextNode
  end
  
  def depth_first
  end
  
  def breadth_first
  end
  
  def self.print_all (hash)
    hash.each do |k, v|
      print "#{k}: "
      print v
      puts
    end
  end
  
end

# Read in file
begin 
  pairs = Hash.new { |h,k| h[k] = [] }
  
  file_name = ( ARGV[0] && ARGV[0] ) || 'bfdf1.txt'
  file = File.open( file_name, 'r' ) { |f| f.read }
  
  file.each_line.with_index do |l,i|
    @nodes = l.split(' ') if i == 0
    @nodes.each do |n|
      pairs [n]
    end
    @start = l.chomp if i == 1
    if i > 1 then
      one, two = l.split(' ')
      pairs.each do |k,v|
        pairs[k] << { two => false } if k == one
        pairs[k] << { one => false } if k == two
      end
    end 
  end
  Graph_Traversal.new @start, pairs 
end


