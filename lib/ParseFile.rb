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
    def initialize(input, returnType)
      $type = returnType.to_s.upcase
      file = File.new( input, 'r')
      unless File.zero?(file)
          if $type == "HASH" then $hash = self.parseHash(file);  
          elsif $type == "FLOAT" then $ary = self.parseFloat(file) end               
      end
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

