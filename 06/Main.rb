require '../class/LinkedList.rb'

begin
  @ll = LinkedList.new
  file_name ||= ( ARGV[0] && ARGV[0] ) || "stack1.txt"
  input = File.open(file_name, 'r') {|f| f.read }
  input.each_line do |l|
    cmd = l.split(" ")
    #puts cmd
    case cmd[0]
    when "PUSH"
      @ll.push cmd[1]
      #puts "pushed #{cmd[1]}"
    when "POP"
      puts @ll.pop 
    when "PRINT"
      @ll.each { |n| puts n }
    when "ENQUEUE"
      @ll.push cmd[1]
    when "DEQUEUE"
      puts @ll.shift
    else
      @ll = LinkedList.new
    end
  end
end