module Join (joinBy) where
-- Do NOT modify anything above this line.
-- Do NOT import anything.

{--
Given a list of strings and a length, return all strings that have the given 
length AND are made by joining three strings from the input list.

Note: The three strings are NOT required to be distinct and the same string 
can be used up to three times.

For example,

    ghci> joinBy 3 ["a", "b"]
    ["aaa", "aab", "aba", "abb", "baa", "bab", "bba", "bbb"]

    ghci> joinBy 4 ["a", "b", "bc", "cd", "d", "def"] 
    ["aabc", "aacd", "bbbc", "bbcd", "abbc", "abcd", "cddd", … ]
in the last example,
"aabc" is made of "a", "a" and "bc";
"aacd" is made of "a", "a" and cd;
"bbbc" is made of "b", "b" and bc;
"abbc" is made of "a", "b" and bc;
"cddd" is made of "cd", "d" and d; and so forth

Note: The order of the resulting strings does not matter.
--}

joinBy :: Int -> [String] -> [String]
joinBy n strs = [str1 ++ str2 ++ str3 | str1 <- strs, str2 <- strs, str3 <- strs, length (str1 ++ str2 ++ str3) == n]

