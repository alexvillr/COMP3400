module FunctionalMap
  ( FunMap (..)
  , empty
  , lookup
  , insert
  , delete
  , fromList
  , changeCurrency
  , convertMarks
  ) where

import Prelude hiding (lookup)
-- Do not modify anything above this line.
--
-- This question is worth 20 POINTS

{--
In this task, you will have to implement a map (dictionary, key-value storage) which will hold keys of type k and values of type v.

The data type for this map is
--}

newtype FunMap k v
  = FunMap
    { getFunMap :: k -> Maybe v }

--
-- Part 1.
--
-- Your task is to implement the usual operations for maps:
-- A function which returns an empty map (a map with no keys and values):

empty :: FunMap k v
empty = undefined

-- A function to search elements in the map by key.
-- If there is an element associated with the given key, the function should return Just element.
-- Otherwise it should return Nothing.

lookup :: Eq k => k -> FunMap k v -> Maybe v
lookup = undefined

-- A function to insert an element into the map and associate it with the given key.
-- If there already IS an element associated with that key, overwrite it.

insert :: Eq k => k -> v -> FunMap k v -> FunMap k v
insert = undefined

-- A function to remove the element and the associated key from the map.
-- If there was no element associated with the key, return the map unchanged.

delete :: Eq k => k -> FunMap k v -> FunMap k v
delete = undefined

-- A function to construct a map from a list of key-value pairs.
-- If there are several values associated with the same key in the list,
-- the last one that appears in the list should be stored in the map.

fromList :: Eq k => [(k,v)] -> FunMap k v
fromList = undefined

-- Part 2.
--
-- Implement the Functor instance for this map:

instance Functor (FunMap k) where
    fmap = undefined

-- fmap should only change elements (values) in the map applying the provided function to them.
-- It should not change keys nor the structure of the map.

-- Using the Functor instance you just defined, implement the following functions:
-- The history of bank transactions is stored in FunMap String Int
-- where String is the name of the transaction and Int is the amount of money in some currency.
-- You need to be able to convert all transactions into another currency given the exchange rate.
-- Implement function

changeCurrency :: (Int -> Int) -> FunMap String Int -> FunMap String Int
changeCurrency = undefined

-- Students’ marks are stored in the grading system in FunMap String Int where
-- String represents student’s name and Int represents their mark in the range [0, 100].
-- You need to write a function that will transform all the marks from the [0, 100] range
-- to ‘A’ to ‘F’ range using the following agreements:
--
-- 84 <= mark <= 100 -> ‘A’
-- 67 <= mark <= 83 -> ‘B’
-- 50 <= mark <= 66 -> ‘C’
-- 34 <= mark <= 49 -> ‘D’
-- 17 <= mark <= 33 -> ‘E’
-- 0 <= mark <= 16 -> ‘F’

convertMarks :: FunMap String Int -> FunMap String Char
convertMarks = undefined

