=begin
  Recursion shortcuts
  
  must meet the following requirements:
      Linear
      Second-order (Two base cases && Two steps backwards)
      Constant coefficients

  Steps:
    1.) Does it match the format? S(n) = C1 S(n-1) + C2 S(n-2)
    2.) Find roots for t^2 - C1t - C2 = 0 
          Roots = r1 and r2 
    3.) Solve for p and q
          s(1) = p + q
          S(2) = p(r1) + q(r2)
    4.) Plug it all into the solution formula
          S(n) = p(r1)^(n-1) + q(r2)^(n-1)
=end