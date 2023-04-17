
evens :: [a] -> [a]
evens [] = []
evens [x] = [x]
evens (x:xs) = x : odds xs

odds :: [a] -> [a]
odds [] = []
odds [x] = []
odds (x:xs) = evens xs

powset :: [a] -> [[a]]
powset [] = [[]]
powset (x:xs) = rest ++ [x:ys | ys <- rest]
  where
    rest = powset xs

quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (pivot:xs) = quicksort ys ++ [pivot] ++ quicksort zs
  where
    ys = [y | y <- xs, y < pivot]
    zs = [z | z <- xs, z >= pivot]

-- Assume Integer >= 0
subSum :: Integer -> [Integer] -> [[Integer]]
subSum 0 _      = [[]]
subSum k (x:xs) = (subSum (k-x) xs) ++ (subSum k xs)
