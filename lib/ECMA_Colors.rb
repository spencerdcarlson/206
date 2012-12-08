module ECMA_Color
     @@color = {
        :red => '31m', :blue => '34m', 
        :green => '32m', :brown => '33m', 
        :purple => '35m', :light_blue => '36m', 
        :gray => '37m', :yellow => '33m' 
      }
      
    def cp(string = "", color = :blue )
        new_string = "\e[;"
        new_string += @@color[color]
        new_string += string
        new_string += "\e[0m"
        return new_string

    end
  
    def list_colors
      colors = []
      @@color.each do |k,v|
        colors << k
      end
      return colors
    end
end

module Kernel; include ECMA_Color end
class Object; include ECMA_Color end