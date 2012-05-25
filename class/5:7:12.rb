Linear Combinations
1.) Find GCD using Euclid''s Algorithm (last devisor devided by remander)
2.) Rewrite as multiplication
3.) Isolate the remainder
4.) Combine small pieces together

Geates Common Divisor == Greatest Common Denominator == Greatest Common Factor

1.) # Find GCD
GCD(420,66)
  a.) 420 / 66 == 6 remandor 24 
  b.) 66 / 24 == 2 remandor 18   
  c.) 24 / 18 == 1 remandor 6     
  d.) 18 / 6 == 3 remandor 0     

2.) # Rewrite
  a.) 420 == 66 * 6 + 24    
  b.) 66 == 24 * 2 + 18   
  c.) 24 == 18 * 1 + 6    
  d.) 18 == 6 * 3 + 0    

3.) # Isolate
  a.) 24 = 420 - ( 6 * 66 )
  b.) 18 = 66 - ( 24 * 2 )
  c.) 6 = 24 - ( 18 * 1 )
  d.) 0 = 18 - ( 3 * 6 )

4.) # Combine
  6 = 24 - 18 # switch 18
  6 = 24 - [ 66 - ( 2 * 24 ) ] # simplify
  6 = ( 3 * 24 ) - ( 1 * 66 ) # sitch out 24
  6 = ( 3 * [ 420 - ( 6 * 66 ) ] ) - ( 1 * 66 ) # simplify
  6 = ( 3 * 420 ) - ( 19 * 66 ) # Answer now contains origional numbers 420 & 66
  
# Fundamental Theorem of Arithmetic
for all integes >= 2
  n is prime or product of primes
  
# Theorem on Division by Primes
if p|ab
  then p|a or p|b
  p is prime, a + b are 2 integers