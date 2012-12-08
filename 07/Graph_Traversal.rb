class Node
  
  attr_reader :neighbors
  attr_reader :name
  attr_reader :visited
  
  attr_writer :visited
  
  def initialize(name)
    @name = name
    @visited = false
    @neighbors = Array.new
  end
  
  def +(neighbor)
    @neighbors << neighbor
  end
  
  def <=>(other_node)
   return self.name <=> other_node.name
  end
  
  def sort_arcs
    @neighbors = @neighbors.sort 
  end 
  
  def dump 
    puts "===== NODE ===="
    puts "Name: #{@name}"
    print "Neighbors: "
    @neighbors.each {|n| print " #{n.name} "}
    puts
    puts "Visited?: #{@visited}"
  end
end

class Graph_Traversal
  
  @start
  @nodes
  
  def initialize 
    read_in
    sort_arcs
    print_nice
    puts
    puts "Depth-First Search: "
    depth_first @start
    puts "\n\n"
    unvisit_all
    breadth_first @start
    #dump
  end
  
  def depth_first(node)
     node.visited = true
     print "#{node.name} "
     node.neighbors.each do |n|
       depth_first n unless n.visited
     end
  end
  
  def breadth_first(node)
    puts "Breadth-First Search: "
    queue = Array.new
    node.visited = true
    print "#{node.name} "
    queue.push(node)
    while (queue.size > 0)
      queue[0].neighbors.each do |n|
        if n.visited == false then
          n.visited = true
          print "#{n.name} "
          queue.push(n)
        end
      end #each
      queue.shift
    end
  end
  
  def unvisit_all
  @nodes.each do |node|
    node.visited = false
  end
  end
  
  def sort_arcs
    @nodes.each do |node|
      node.sort_arcs
    end
  end
  
  def print_nice
    puts "Node Neighbors: "
    @nodes.each do |node|
      print "#{node.name}: "
      node.neighbors.each {|n| print " #{n.name} "}
      puts
    end
  end
  
  def dump
    puts "Start: #{@start.name}"
    @nodes.each do |node|
      puts node.dump
    end
  end
  
  def fetch_by_name(name)
    @nodes.each do |node|
     return node if node.name == name
    end  
  end
 

  def read_in 
    file_name = ( ARGV[0] && ARGV[0] ) || 'homeWork1.txt'
    file = File.open( file_name, 'r' ) { |f| f.read }
    @node_list = file.lines.first.split(' ')
    file.each_line.with_index {|l,i| @start = l.chomp if i == 1 }
    @nodes = Array.new
    @node_list.each do |node|
      new_node = Node.new node.chomp
      @nodes << new_node
    end
    file.each_line.with_index do |l,i|
      if i > 1
        from, to = l.split(' ')      
        @nodes.each do |node| 
          node + fetch_by_name(to) if node.name == from
          node + fetch_by_name(from) if node.name == to      
        end
      end
    end
    #Set start to node object
    @nodes.each do |node|
      @start = node if node.name == @start
    end
  end
  
 
end

begin 
  Graph_Traversal.new
end

