require './Intelligence.rb'


class Person < Intelligence
 
  attr_reader :guilty
  attr_reader :name
  attr_reader :likes_and_dislikes
  
  @@options = 4
  
  def initialize(name)
    @name = name
    @guilty = false
    init_responses
  end
  
  def self.options(new_options = nil)
    @@options = new_options if new_options
    return @@options
  end
  
  def self.facts
    [@@yes,@@no]
  end
  
  def set_guilty
    @guilty = true
  end
  
  def init_responses
    @likes_and_dislikes =  @@options.times.map { 
      if Random.rand(2) == 0 then false else true end
    }
  end
  
  def speak(person)
    random_response = Random.rand(@@options)
    if @guilty
      # talking about themselves
      if person.name.eql? self.name
        puts "#{name}: I #{@@Ino[random_response]}" if person.likes_and_dislikes[random_response]
        puts "#{name}: I #{@@Iyes[random_response]}" if !(person.likes_and_dislikes[random_response])
      else
        puts "#{name}: #{person.name} #{@@no[random_response]}" if person.likes_and_dislikes[random_response]
        puts "#{name}: #{person.name} #{@@yes[random_response]}" if !(person.likes_and_dislikes[random_response])
      end
      #puts "I'm guilty"
      #lie = !(person.likes_and_dislikes[random_response])
      #puts "#{name}: Says Option #{random_response} about #{person.name} :: ANSWER - #{lie}"
    else
      # talking aobut themselves
      if person.name.eql? self.name
          puts "#{name}: I #{@@Iyes[random_response]}" if person.likes_and_dislikes[random_response]
          puts "#{name}: I #{@@Ino[random_response]}" if !(person.likes_and_dislikes[random_response])
      else
        puts "#{name}: #{person.name} #{@@yes[random_response]}" if person.likes_and_dislikes[random_response]
        puts "#{name}: #{person.name} #{@@no[random_response]}" if !(person.likes_and_dislikes[random_response])
      end
      #puts "#{name}: Says Option #{random_response} about #{person.name} :: ANSWER - #{person.likes_and_dislikes[random_response]}"
    end
  end
  
  def dump
  puts "========PERSON======="
  puts "Name: #{@name}"
  puts "Guilty: #{@guilty}"
  @likes_and_dislikes.each_with_index do |o,i|
    puts "Option #{i}: #{o}"
  end
  puts "********************"
  end
  
end
