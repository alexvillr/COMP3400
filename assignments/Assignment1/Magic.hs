module Magic (magic, factorials, listTails, cumulative) where

import           Prelude hiding (foldl, foldl', foldl1, foldr, foldr', foldr1,
                          scanl, scanl', scanl1, scanr, scanr', scanr1) 
-- Do not modify anything above this line.
-- Do NOT import anything.

{--
Implement
    magic ::  (b -> a -> b) -> b -> [a] -> [b]
so that is can be used to implement the following functions.

Then implement each function by using magic.
--}

magic :: (b -> a -> b) -> b -> [a] -> [b]
magic _ b [] = []
magic fn b [a] = b : [fn b a]
magic fn b (a:as) = b : magic fn (fn b a) as

-- | factorials is a list of factorials of integer numbers starting from 0:
-- factorials = [1, 1, 2, 6, 24, ...]
factorials :: [Int]
factorials = magic (*) 1 [1..]

-- | listTails is a function that returns all lists obtained by consecutively 
-- discarding the first element of the argument list, longest first. For 
-- example, listTails [1, 2, 3, 4] = [[1, 2, 3, 4], [2, 3, 4], [3, 4], [4], []]
listTails :: [a] -> [[a]]
listTails list = magic (\(_:as) ass -> as) list list

-- | cumulative is a function that takes a list and returns cumulative sums of 
-- its elements, i.e. i-th element in the resulting list is the sum of the first
-- i elements of the input list.
-- In the example below, 0 is the sum of zero numbers, 3 = 1 + 2; 6 = 1 + 2 + 3 
-- and so forth.
-- cumulative [1, 2, 3, 4, 1] = [0, 1, 3, 6, 10, 11]
cumulative :: [Int] -> [Int]
cumulative = magic (+) 0

