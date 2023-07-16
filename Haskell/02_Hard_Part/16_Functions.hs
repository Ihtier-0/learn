import Data.List (foldl')

evenSum1 :: Integral a => [a] -> a
evenSum1 = (foldl' (+) 0) . (filter even)

sum' :: Num a => [a] -> a
sum' = foldl' (+) 0

evenSum2 :: Integral a => [a] -> a
evenSum2 = sum' . (filter even)