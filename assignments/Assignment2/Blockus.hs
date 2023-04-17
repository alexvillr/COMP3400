module Blockus (tile) where

-- Do not modify anything above this line.
--
-- This question is worth 10 POINTS

{--
Implement the tiling from Q10 in the Written Assignment.

Implement function 
	tile :: Int -> [[Int]]

which will construct the tiling of a board 2^k x 2^k for the given k.
If k is less than zero, return an empty list.
In the output, each V3 piece should be assigned a unique positive non-zero number. 
The upper left corner should be assigned a 0. 
For example, the tiling for a 4x4 Board might look like this:

0 1 4 4 
1 1 2 4
5 2 2 3
5 5 3 3

So, 
    tile 2 == [[0, 1, 4, 4]
              ,[1, 1, 2, 4] 
              ,[5, 2, 2, 3] 
              ,[5, 5, 3, 3]]

Note that this solution is not unique. Any valid solution will be accepted.

--}

tile :: Int -> [[Int]]
tile 0 = [[0]]     -- define vacuous case
tile 1 = [[0, 1]   -- define nth case
         ,[1, 1]]
tile n = undefined -- recursive step


htile :: Int -> Int -> [[Int]]
htile 0 0 = [[0]]
htile _ _ = undefined

flipx :: [[Int]] -> [[Int]]
flipx = undefined

flipy :: [[Int]] -> [[Int]]
flipy = undefined

combine :: [[Int]] -> [[Int]] -> [[Int]] -> [[Int]] -> [[Int]]
combine ws xs ys zs = undefined
