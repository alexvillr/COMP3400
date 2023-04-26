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
lcVariance [] = undefined
lcVariance [x]  = 0
lcVariance (x:xs)= (/) ((+) ((+) ((*) n (lcVariance xs)) ((*) n ((** 2) (lcMean xs)))) ((** 2) x)) (n + 1) - lcMean (x:xs) **2
  where
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
 - trVariance n avg s xs = (Something that should be the variance of xs ++ (previous list))
 -
 - trVariance n avg s xs = ((n * (s + (avg ** 2)) + (x ** 2)) / (n + 1)) - (avg' ** 2)
 -
 - trVariance 0 0 0 (x:xs) = ((0 * (0 + (0 ** 2)) + (x ** 2)) / 1) - (htrMean 0 0 [x] ** 2)
 -                         = (x ** 2) - (avg x)
 -                         = 0
 -
 -
 - trVariance n avg s (x:xs) = 
 -}

{-
 - __Bound value:__
 - 
 - 
 - 
 - 
 - 
 - 
 - 
 - 
 -}


-- Var(X + c) = Var(X), where c is some constant.
property1 :: IO()
property1 = quickCheck $ \a xs -> null xs || abs (variance (map (+ a) xs) - variance xs) < 10**(-1)

-- Var(aX) = a^2 * Var(X), where a is some constant.
property2 :: IO()
property2 = quickCheck $ \a xs -> null xs || abs (variance (map (a *) xs) - ((a ** 2) * variance xs)) < 10**(-1)

-- Var(aX + b) = a^2 * Var(X), the result of the previous two properties combined.
property3 :: IO()
property3 = quickCheck $ \a b xs -> null xs || abs (variance (map (\x -> a * x + b) xs) - ((a ** 2) * variance xs)) < 10**(-1)