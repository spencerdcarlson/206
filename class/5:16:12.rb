Encoding & Mods

0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
a b c d e f g h i j k  l  m  n  o  p  q  r  s  t  u  v  w  x  y  z 

Excoding Example:
origional: The Cat In The Hat
encoded: Aol Jha Pu Aol Oha 
Key: 7
index + key % size

T: 19 + 7 % 26 = 0 
  0 = A
  T == A
H: 7 + 7 % 26 =  14
  14 = o
  H == o
  
Decoding Example:
origional: Spencer
encoded: M
Key: 20
index - key % length

M: 12 - 20 % 26 = 18
  18 = S
  S == M


Also used to iterate trhough an array:
current = ( current + 1 ) % size
Example: 
@array = [0..10];

Timer (500) {
  $current = ( $current + 1 ) % @array.size
}