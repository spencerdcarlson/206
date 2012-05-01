class Fibonacci
  
  def initialize(num)
    @n = num
    @info = {
      "Origional" => num, "Fib" => fib(@n), 
      "FibTwo" => fibTwo(@n), "FibFast" => fibFast(@n) }
  end
  
  def fib(x)
    if x == 1 || x == 2 then 1 else fib(x-1) + fib(x-2) end
  end
  
  def fibTwo(x)
    result = 1 ; prev = -1
    for i in 0..x do sum = (result + prev ); prev = result; result = sum end
    result 
  end
    
  def fibFast(x)
    #Gr = Golden Ratio
    gr = ( 1 + Math.sqrt(5) ) / 2
    gr**x  / Math.sqrt(5)  + 0.5
  end
  
  def show
    @info.each do |key,value|
      puts "#{key}: " + sprintf("%.2f", value)
    end
  end
  
end

f = Fibonacci.new(20)
f.show



