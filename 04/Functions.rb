# PROJECT: Functions
$LOAD_PATH << '../lib'
require 'parseFile.rb'

class Functions
  def initialize(file)
    @domain = file[0]
    @codomain = file[1]
    # Key elements
    @keys = file[2].values_at(*file[2].each_index.select {|i| i.even?})
    # Value elements
    @values = file[2].values_at(*file[2].each_index.select {|i| i.odd?})
    @values.compact!
    # array of duplicates
    @dup = false
    if @keys.detect{ |e| @keys.count(e) > 1 }
        @dup = true
        @duplicates = Array.new()
        @duplicates.push( @keys.detect{ |e| @keys.count(e) > 1 } )
    end
    # Hash of k => value
    @relation = Hash[*file[2]]
    show
  end
  
  def show
    
    puts "Domain: #{@domain}" 
    puts "Codomain: #{@codomain}"
    if @dup
      print "Relation: ["
      for i in 0..@keys.size-1 do
        print " ("
        print " \"#{@keys[i]}\" "
        print "=>"
        print " \"#{@values[i]}\" "
        print ") "
      end
      print "] "
      puts "This is *not* a function"
    else
      @on_to = true
      match = 0
      @values.each do |v|
        if @relation.has_value? v then match += 1 end
        unless @relation.has_value? v
          @on_to = false
          break
        end
      end
      @on_to = false if match <  @codomain.size
      puts "Relation: #{@relation}"
      if @on_to then puts "This is onto"; @on_to = true else puts "This is *not* onto"end
      @one_to_one = false
      if @values.detect{ |e| @values.count(e) > 1 } then puts "This is *not* one-to-one" else
        puts "This is one-to-one"
        @one_to_one = true
      end
      if @on_to && @one_to_one then puts "This is a bijection" else puts "This is *not* a bijection" end
    end
  end
end

begin
  parsed = Master::ParseFile.new("lines")
  if parsed.getFile.instance_of?(Array) then Functions.new(parsed.getFile) end
end