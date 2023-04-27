module Variance where
import Test.QuickCheck (quickCheck)

lcMean :: [Float] -> Float
lcMean [] = undefined
lcMean [x] = x
lcMean (x:xs) = (x + n * average) / (n + 1)
  where
    average = lcMean xs
    n       = fromIntegral (length xs)

lcVariance :: [Float] -> Float
lcVariance []     = undefined
lcVariance [x]    = 0
lcVariance (x:xs) = (((n * s') + (n * (avg ** 2)) + (x ** 2)) / (n + 1)) - (avg' ** 2)
  where
    avg = lcMean xs
    avg' = lcMean (x:xs)
    s' = lcVariance xs
    n = fromIntegral (length xs)

trMean :: [Float] -> Float
trMean [] = undefined
trMean xs = htrMean 0 0 xs

htrMean :: Float -> Float -> [Float] -> Float
htrMean _ avg []     = avg
htrMean n avg (x:xs) = htrMean n' avg' xs
  where
    n'   = n + 1
    avg' = (x + (avg * n)) / (n + 1)

trVariance :: Float -> Float -> Float -> [Float] -> Float
trVariance _ _ s []      = s
trVariance n avg s (x:xs) = trVariance n' avg' s' xs
  where
    n'   = n + 1
    avg' = htrMean n avg [x]
    s'   = ((n * (s + (avg ** 2)) + (x ** 2)) / (n + 1)) - (avg' ** 2)

variance :: [Float] -> Float
variance [] = undefined
variance xs = trVariance 0 0 0 xs

{- 
 - __Iteration invariant:__
 -
 - where ys is everything processed already, n = length ys
 - trVariance n avg s (x:xs) = (n + 1) (the average of (x:ys)) (the variance of x ++ y) xs
 -
 - 
 - trVariance n avg s [] = s 
 -                       = variance ys
 - Meaning that we have the variance of the whole list that has now been processed.
 -
 - trVariance n avg s (x:xs) = trVariance (n + 1) (avg (x:ys)) ((n * (s + (avg ** 2)) + (x ** 2)) / (n + 1)) - ((avg (x:ys)) ** 2) xs
 -                           = trVariance (n + 1) (avg (x:ys)) ((n * ((sum (ys ** 2)) / n) + (x ** 2)) / (n + 1)) - (avg (x:ys) ** 2) xs
 -                           = trVariance (n + 1) (avg (x:ys)) ((sum (ys ** 2) + (x ** 2)) / (n + 1)) - (avg (x:ys) ** 2) xs
 -                           = trVariance (n + 1) (avg (x:ys)) ((sum ((x:ys) ** 2)) / (n + 1)) - (avg (x:ys) ** 2) xs
 -                           = trVariance (n + 1) (avg (x:ys)) ((1 / (length (x:ys)) * (sum (x:ys) ** 2)) - (avg (x:ys) ** 2) xs
 -                           = trVariance (n + 1) (avg (x:ys)) (variance (x:ys)) xs
 - Meaning that we have the variance of (ys:x) and will continue to process with the rest of the list
 - that hasn't been processed yet.
 -
 - trVariance 0 0 0 (x:xs) = trVariance (0 + 1) (avg (x)) (((0 * (0 + (0 ** 2)) + (x ** 2)) / 1) - (htrMean 0 0 [x] ** 2)) xs
 -                         = trVariance (0 + 1) (avg (x)) ((1 / 1 * (x ** 2)) - ((avg x) ** 2)) xs
 -                         = trVariance (0 + 1) (avg (x)) (variance x) xs
 -                         = trVariance 1 x 0 xs
 - Meaning that the first call will always return a variance of 0 which is correct for the variance of 1 value.
 -
 -}

{-
 - __Bound value:__
 - 
 - length of xs
 - 
 - each time we take an element out of xs and process it
 - so each iteration shortens the length of the list
 - our function can never be called on an empty list
 - once we run out of elements in the list we return and finish
 - 
 -}

-- Var(X) > 0
property1 :: IO()
property1 = quickCheck $ \xs -> null xs || variance xs >= 0

-- Var(X + c) = Var(X), where c is some constant.
property2 :: IO()
property2 = quickCheck $ \a xs -> null xs || abs (variance (map (+ a) xs) - variance xs) < 10**(-1)

-- Var(aX) = a^2 * Var(X), where a is some constant.
property3 :: IO()
property3 = quickCheck $ \a xs -> null xs || abs (variance (map (a *) xs) - ((a ** 2) * variance xs)) < 10**(-1)

-- Var(aX + b) = a^2 * Var(X), the result of the previous two properties combined.
property4 :: IO()
property4 = quickCheck $ \a b xs -> null xs || abs (variance (map (\x -> a * x + b) xs) - ((a ** 2) * variance xs)) < 10**(-1)