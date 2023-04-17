module Foo where

mode :: (Eq a) => [a] -> a
mode = fst . biggest . frequency

frequency :: (Eq a) => [a] -> [(a, Integer)]
frequency [] = []
frequency (x:xs) = join x ys
  where
    ys = frequency xs

join :: (Eq a) => a -> [(a, Integer)] -> [(a, Integer)]
join x [] = [(x, 1)]
join x ((y, numYs):rest)
    | x == y    = (y, numYs+1):rest
    | otherwise = (y, numYs):join x rest

biggest :: [(a, Integer)] -> (a, Integer)
biggest [] = undefined
biggest [(x, numXs)] = (x, numXs)
biggest ((x, numXs):rest)
    | numXs >= numYs = (x, numXs)
    | otherwise      = (y, numYs)
  where
    (y, numYs) = biggest rest

