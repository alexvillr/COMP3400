module Shortest (shortest) where

-- Do not modify anything above this line.
--
-- This question is worth 10 POINTS

{--
shortest is a function that receives a list of lists and returns the shortest 
list if there is one, and Nothing otherwise.

	shortest :: [[a]] -> Maybe [a]

Your implementation must satisfy the following requirements:
1. It must work even if there are infinite lists in the input (see *).
2. It must work even if the input list itself is infinite (see *).
3. If there are several lists with the minimal length, return the first of them.

	* We guarantee that for all test inputs (visible and hidden), it will be 
possible to find a solution within a reasonable amount of time using an 
appropriate algorithm. For example, there won’t be any infinite lists of 
infinite lists in the tests.

For example,
        shortest  [[1, 3..], [10..], repeat 5, [2, 4], [2, 4..], [42, 228]] 
            == Just [2, 4]
--}

shortest :: [[a]] -> Maybe [a]
shortest = undefined
