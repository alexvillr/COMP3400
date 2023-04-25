module Variance where

lcMean :: [Float] -> Float
lcMean [] = undefined
lcMean [x] = x
lcMean (x:xs) = (x + n * average) / (n + 1)
  where
    average = lcMean xs
    n       = fromIntegral (length xs)

lcVariance :: [Float] -> Float
lcVariance [] = undefined
lcVariance [x]  = 0
lcVariance (x:xs)= (/) ((+) ((+) ((*) n (lcVariance xs)) ((*) n ((** 2) (lcMean xs)))) ((** 2) x)) (n + 1) - lcMean (x:xs) **2
  where
    n = fromIntegral (length xs)

{- 
 - __Iteration invariant:__
 -
 - h_trMean n avg xs = (Something that should be the average of xs ++ (previous list))
 -
 - h_trMean n avg xs = ((n * avg) + sum(xs)) / (n + length xs)
 -
 - h_trMean 0 0 xs = (0 * 0 + sum xs) / (0 + length xs)
 -                 = (sum xs) / (length xs)
 -                 = mean xs
 -}

trMean :: [Float] -> Float
trMean [] = undefined
trMean xs = htrMean 0 0 xs

htrMean :: Float -> Float -> [Float] -> Float
htrMean _ avg []     = avg
htrMean n avg (x:xs) = htrMean (n + 1) ((x + n * avg) / (n + 1)) xs

{--
Variance_{n+1} = \frac{(n Variance^2_{n}) + (n xbar^2_{n}) + (x^2_{n+1})}{n + 1} - xbar^2_{n+1}
--}

trVariance :: Float -> Float -> Float -> [Float] -> Float
trVariance _ _ s [x]      = s
trVariance n avg s (x:xs) = trVariance (n + 1) (avgnplus1) ((((n * (s + (avg ** 2))) + (x ** 2)) / (n + 1)) - (avgnplus1 ** 2)) xs
  where
    avgnplus1 = htrMean (n + 1) avg [x]

variance :: [Float] -> Float
variance [] = undefined
variance xs = trVariance 0 0 0 xs


