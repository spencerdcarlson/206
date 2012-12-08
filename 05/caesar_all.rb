#Caesar Cipher
class Caesar_cipher
  
  def initialize(file)
    @key
    @msg

    #parse file
    file.each_line { |l| 
      if l.to_i == 0 
        @msg = l.split(" ")
      else @key = l.to_i end 
    }
    encode(@msg, @key)
  end
  
  def encode(msg, key)
    @encoded = ""
    numbers =  (1..26).to_a
    alpha = ('a'..'z').to_a
    for i in 1..26 do
      msg.each do |m|
        m.each_char do |c|
          index =  ( alpha.index(c.downcase)  - i ) % 26
          @encoded << alpha[index]
        end
        @encoded << " "
      end
      print "#{i}.) "
      @encoded << "\n"
      puts @encoded.capitalize!
      @encoded.clear
    end
    #puts key
  end
 
end #Caesar Cipher

begin
  fileName ||= ( ARGV[0] && ARGV[0] ) || 'ans/input1a.txt'

  # create new file && read it in
  file = File.open( fileName, 'r'){ |f| f.read }
  
  Caesar_cipher.new(file)
    
  rescue Errno::ENOENT
    puts "\nFile not found: #{$!}"
    puts 'Please specify another file or type \'q\' to quit'
    input = $stdin.gets.chomp
    if input.casecmp('q') == 0; exit else fileName = input; retry end
end