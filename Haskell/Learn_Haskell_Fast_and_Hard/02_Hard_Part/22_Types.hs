data Complex where
  Complex :: Num a => {real :: a, img :: a} -> Complex

c = Complex 1.0 2.0
z = Complex { real = 3, img = 4 }

main = undefined