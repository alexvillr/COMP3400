module Tut06Ans where

-- Show how the list comprehension [f x | x <- xs, p x]| can be re-expressed using 
-- the higher-order functions map and filter.
bar :: (a -> b) -> (a -> Bool) -> [a] -> [b]
bar f p xs = map f $ filter p xs
-- Note: since in the list comprehension we're applying the predicate to x, we
-- need to filter before we map (i.e. feed the result of filtering into map)

-- Define takeWhile and dropWhile using higher-order functions.
takeWhilez :: (a -> Bool) -> [a] -> [a]
takeWhilez p = foldr (\x sofar -> if p x then x : sofar else []) []
{- Remember that foldr :: (a -> b -> b) -> b -> [a] -> b
Going from the right of the input list, we build a list of items that satisfy predicate p - but when
we run into an item that doesn't satisfy p, we drop the result so far and replace it with an empty 
list; we start collecting again from scratch. The end result is that we get a list of elements up 
until the first element that doesn't satisfy p -}

dropWhilez :: (a -> Bool) -> [a] -> [a]
dropWhilez p =  foldl (\sofar x -> if null sofar && p x then sofar else sofar ++ [x]) []
{- Remember that foldl :: (b -> a -> b) -> b -> [a] -> b
Going from the left, we start with an empty list. We want to add to this list only once at least one
item has failed to satisfy the predicate. If the list so far is empty, and the current item
satisfies the predicate, we know we want to continue to dropping, so we exclude x from the result.
Once we reach an answer that doesn't satisfy the predicate, we begin adding to the result, and every
subsequent element will be added. -}

-- Consider the higher-order function foo
foo :: (t -> Bool) -> (t -> a) -> (t -> t) -> t -> [a]
foo p h t x
    | p x       = []
    | otherwise = h x : foo p h t (t x)

-- Define takeWhile by equating it to a single invocation of foo.
takeWhilex :: (a -> Bool) -> [a] -> [a]
takeWhilex prop xs = foo (not.prop.head) head tail xs
{- Once p in foo holds, it will stop recursing/end the list with []. We want to end the list
once prop (in takeWhile) no longer holds, so we will
- extract the head of the list
- check if prop holds
- negate that result
The 'item' that foo will be operating on is a list. If p doesnt hold, it'll add something to the
start of a list - we want to add the head of the list its operating on, so pass 'head' as the second
argument. The third argument needs to 'move on' to the rest of the list, so we pass 'tail'. 
Note: this solution is not total. To make it total, we would need to modify our stopping condition
to handle the empty list properly. -}

-- Define map by equating it to a single invocation of foo.
mapx :: (a -> b) -> [a] -> [b]
mapx func xs = foo null (func.head) tail xs
{- Our stopping condition is when the list is empty - use 'null' here.
For each element in xs, we want to apply some function to it. Since the item we are working with in
foo is a list, we need to get its head first, before applying the function. -}

-- Define iterate by equating it to a single invocation of foo.
-- iterate f x returns an infinite list of repeated applications of f to x
iteratex :: (a -> a) -> a -> [a]
iteratex f x = foo (const False) id f x
{- There is no stopping condition, because we want this to return an infinite stream - so our 
p function will be a function that always returns false.
To the front of our list, we want to add the current item.
To 'move on' to the next item, we want to apply f to the current item, so that through repeated
calls to foo, we get [x, f x, f (f x), f (f (f x)), ...] -}
