# Print Interpreter path
require 'rbconfig'
puts "Path to Interpreter: "
puts RbConfig.ruby()
puts 

# Print Gem path
require 'rubygems'
puts "Gem Paths: "
puts Gem.path
puts

# Prints all directories from which you can load gems and files
puts "Load Path: "
puts $LOAD_PATH
puts

# Prints the where require looks for files 
puts $:
# looks in the same directory as the file where the method is called
require_relative 'ClassA' 
# which looks in the current working directory
require './ClassA' 