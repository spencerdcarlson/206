# Module for parsing different types of files
module Master
  
  
  
  # Class to parse a File
  class ParseFile
    ##
    # Send this class a file and a object type.
    # The object indicates what is in the file and implies a return type
    #
    # Indicated file types:
    #    Hash => file that contains two items sperated by a space
    #    Float => A file that contains a list of Floats, 0 or Many on one line
    #
    # Return tpyes based on calss:
    #    Hash => Hash 
    #    Float => Array
    #
    def initialize(returnType)
      # If file name exists do nothing. 
      #If it doesn't, check to see if ARGV[0] exists and assign it to fileName. 
      #If ARGV[0] doesn't exist assign 'input1.txt' to fileName
      fileName ||= ( ARGV[0] && ARGV[0] ) || 'input1.txt'

      # create new file
      file = File.new( fileName, 'r')
      
      $type = returnType.to_s.upcase
      
      unless File.zero?(fileName)
          if $type == "HASH" then $hash = self.parseHash(file);  
          elsif $type == "FLOAT" then $ary = self.parseFloat(file) end               
      end

      rescue Errno::ENOENT
        puts "\nFile not found: #{$!}"
        puts 'Please specify another file or type \'q\' to quit'
        input = $stdin.gets.chomp
        if input.casecmp('q') == 0; exit else fileName = input; retry end
      ensure
        file.close if file
    end
    
    def parseHash(file)
      hash = {}
      file.each { |line| hash.update(line.split(" ")[0].to_s.upcase => line.split(" ")[1].to_f ) }
      return hash
    end
    
    def parseFloat(file)        
      nums = Array.new
      while (line = file.gets)
        num = line.split(" ")
        num.each { |item| nums.push(Float(item)) }
      end
      return nums
    end
    
    def getFile
      if $type == 'HASH' then return $hash
      elsif $type == 'FLOAT' then return $ary end
    end
    
  end #class
end #module

