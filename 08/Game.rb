require './Person.rb'
require 'eventmachine'
require '../lib/ECMA_Colors.rb'


class Game

  
  @@names = [ cp("Bruno", :blue), cp("Clyde", :green), cp("Duke", :yellow), cp("Esmerelda", :purple),"Spencer", "Jacob", "Dr. Draper"]
  @@people = Array.new
  
  def initialize(num_people = 4, options = nil)
    raise "Too Many People " if num_people > @@names.size
    default_options = Person.facts
    raise ArgumentError.new("Too Many Options") if options > default_options[0].size 
    Person.options(options)
    @guilty = Random.rand(num_people)
    num_people.times do |i|
      person = Person.new(@@names[i])
      person.set_guilty  if @guilty == i
      @@people.push(person)
    end
    #debug
    
    rescue ArgumentError => e
      add_fact(e)
    rescue Exception => e
  	  add_people(num_people, e)
	  else
	    start_game 
  end
  
  def start_game
    intro = "Detective, please enter your name for verification:"
    puts intro
    name = STDIN.gets.chomp
    
    story = "Detective #{name} thank you for joing us today. We really need your help
It appears that things got out of control at the Gatsby Mansion again. This time worse then ever
we regret to informe you... There has been a murder
We've detained the suspects, but we need you to interogate them
We know that the killer is a liar and will always lie, while the inocennt will never lie!
Each suspect is in the following rooms:\n"
      
    story1 = "To ask them a question type their room number ( Example: 1 to speak to #{@@people[0].name} )
If you forget their room number, just type 'room' to print out a room list
To accuse a suspect of being the killer, Type 'A' 
But be careful, this interogation isn't exatly leagl....
You'll only get one guess before they call their lawyers, and then we'll never know
If at anytime you want to give up, press 'Q' for Quit
Good luck\n"
    
    
    
    EventMachine.run {
      x = 0
      EventMachine::PeriodicTimer.new(0.01){
       EventMachine.set_quantum(10)
        if story[x].match '\n'
          pause = 15000000
          while (pause > 0) 
            pause -= 1
          end
        end
        print story[x]
        x += 1
        EventMachine.stop if x == story.size
      }
    }
    #puts story
    @@people.each_with_index { |p,i| puts "    Room: #{i+1} - #{p.name} " } 
    EventMachine.run {
      x = 0
      EventMachine::PeriodicTimer.new(0.01){
       EventMachine.set_quantum(10)
        if story1[x].match '\n'
          pause = 15000000
          while (pause > 0) 
            pause -= 1
          end
        end
        print story1[x]
        x += 1
        EventMachine.stop if x == story1.size
      }
    }
    #puts story1
    
=begin
    
    puts "Detective, please enter your name for verification: "
    name = STDIN.gets.chomp
    puts "  Detective #{name} thank you for joing us today. We really need your help"
    puts "  It appears that things got out of control at the Gatsby Mansion again. This time worse then ever"
    puts "  we regret to informe you... There has been a murder"
    puts "  We've detained the suspects, but we need you to interogate them"
    puts "  We know that the killer is a liar and will always lie, while the inocennt will never lie!"
    puts "  Each suspect is in the following rooms: "
    @@people.each_with_index {|p,i| puts "    Room: #{i+1} - #{p.name} " }
    puts "  To ask them a question type their room number ( Example: 1 to speak to #{@@people[0].name} )"
    puts "  If you forget their room number, just type 'room' to print out a room list"
    puts "  To accuse a suspect of being the killer, Type 'A' "
    puts "  But be careful, this interogation isn't exatly leagl...."
    puts "  You'll only get one guess before they call their lawyers, and then we'll never know"
    puts "  If at anytime you want to give up, press 'Q' for Quit"
    puts "  Good luck"
=end
    accuse = false
    begin
    # Get input
    action = STDIN.gets.chomp.downcase
    
    if action.to_i > 0 && accuse == false 
      if action.to_i > @@people.size then puts "No one is in room #{action.to_i}"; next end
      speaker = @@people[action.to_i-1]
      about = @@people[Random.rand(@@people.size)]
      speaker.speak(about)
      #puts "#{speaker.name}: about #{about.name}"
    end
    if action.eql? 'a' or accuse == true
      puts "Who would you like to accuse? " if action.eql? 'a'
      if accuse == true
        if action.eql? 'room' then @@people.each_with_index {|p,i| puts "Room: #{i+1} - #{p.name} " }; next end 
        if action.to_i > @@people.size then puts "No one is in room #{action.to_i}"; next end
        accused = @@people[action.to_i-1]
        if accused.guilty == true
           puts "Congradulations, you guessed right! #{accused.name} was the murder"
           exit
        else
          puts "Sorry, you guessed wrong #{accused.name} was not the murder"
          @@people.each do |p|
            puts "The murder was #{p.name}" if p.guilty == true
          end
          exit
        end
      end
      accuse = true
    end
    
    if action.eql? 'z'
      debug
    end
    
    if action.eql? 'room' then @@people.each_with_index {|p,i| puts "Room: #{i+1} - #{p.name} " } end  
    
    # Exit if input == q
    end while not action.eql? 'q' 
  
    
  end
  
  def people
    @@people
  end
  
  def add_people(num_people, e)
    puts e
    while ( num_people > @@names.size )
      puts "Add new Character: "
      ## PROBLEM
      new_name = STDIN.gets
      if new_name
        new_name = new_name.chomp 
      else 
        new_name = "Zelda #{@@names.size}"
      end

      @@names.push(new_name)
    end
    @guilty = Random.rand(num_people)
    num_people.times do |i|
      person = Person.new(@@names[i])
      person.set_guilty  if @guilty == i
      @@people.push(person)
    end
    #debug
    start_game
  end
  
  def add_fact(e)
    abort e.to_s
  end
  
  def debug
    options = Person.facts
    options[0].each_with_index do |o,i|
      puts "Option: #{i} => #{o}"
    end
    @@people.each do |p|
      p.dump
    end
  end


end

class Start
  def self.new_game 
    num_people = 0
    num_options = 0
    num_people = ( ARGV[0] && ARGV[0] ) || 4
    num_options = ( ARGV[1] && ARGV[1] ) || 5
    num_people = num_people.to_i
    num_options = num_options.to_i
    Game.new( num_people, num_options )
  end
end

begin
  Start.new_game
end 