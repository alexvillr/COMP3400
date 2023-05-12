{-# LANGUAGE CPP #-}

module WordleWithNumbers (
    solve,
) where

#ifdef GRADESCOPE
import           AutograderUtils (print, readLn)
import           Prelude         hiding (print, readLn)
#endif

-- This task is worth 20 POINTS
-- Do NOT modify anything above this line.
-- Do NOT use any imports.

{--

In this assignment, you will implement an algorithm to solve a game called
"Wordle With Numbers," which is similar to the popular game Wordle, but
instead of guessing a word, you will be guessing a sequence of numbers.

Game description

The computer will generate a random sequence of N numbers, where N is a number
between 1 and 1000, inclusive. Each number in the sequence is in the range
[0..9]. Your task is to guess the sequence. To play the game, you will need to
implement an IO function called `solve` that interacts with the standard
input-output (terminal) and guesses the sequence.

Each round of the game proceeds as follows:
    1. You input a sequence into the terminal.
    2. The computer outputs a tuple of two lists of integers,
            (strongMatch, weakMatch).
    -  strongMatch is a list of positions (0-based) in your guess where you
            guessed both the number and its position correctly.
    -  weakMatch is a list of positions (0-based) in your guess where you
            guessed the number correctly, but its position is wrong.

For example, suppose the computer generated a sequence of 5 numbers:
        [9, 3, 5, 5, 1].
If your guess is [1, 2, 3, 4, 5], the computer will output ([], [0, 2, 4]),
indicating that there are no numbers in the correct positions, but the numbers
1, 3, and 5 are present in both sequences.

If your guess is [2, 3, 4, 5, 5], the computer will output ([1, 3], [4]),
indicating that you correctly guessed the numbers in positions 1 and 3, and
also correctly guessed the number 5, but in the wrong position.

If you guess the sequence, the computer will output ([0, 1, 2, ..., N-1], [])
and the game will end.

If the length of your guess does not match the length of the sequence, or any
of the numbers in your guess are out of range [0..9], the computer will output
([-1], [-1]).

Your task is to implement an IO function which will interact with the standard
input-output (terminal) and guess the sequence.

		solve :: IO ()

When called, solve should do the following:
    1. Read an integer N from the terminal, indicating the length of the
            sequence to be guessed.
    2. In each round of the game, output a sequence of N numbers, each in the
            range [0..9],
       and read the computer's response (a tuple of two lists of integers).
    3. Repeat step 2 until the sequence is guessed (i.e., until the computer's
            response is ([0, 1, 2, ..., N-1], [])).

A possible interaction might look like this:
Suppose the computer created a sequence of 5 numbers: [9, 3, 5, 5, 1].
Lines with ODD numbers will represent computer output which your function
should read from the standard input. The other lines should be printed by solve.

N> represents the line with number N. "N>" is not a part of the input-output.
> solve
1> 5
2> [1, 2, 3, 4, 5]
3> ([], [0, 2, 4])
4> [1, 1, 1, 1, 1]
5> ([4], [])
6> [5, 4, 3, 2, 1]
7> ([4], [0, 2])
8> [5, 5, 1, 3, 9]
9> ([], [0, 1, 2, 3, 4])
10> [1, 2, 4]
11> ([-1], [-1])
12> [10, 3, 5, 5 ,1]
13> ([-1], [-1])
14> [9, 3, 5, 5, 1]
15> ([0, 1, 2, 3, 4], [])

Use the function `readLn` to read something from the standard input (terminal)
and `print` to print something to the standard output (terminal).
Use only these functions to perform input-output because otherwise your solution
won’t be tested and graded properly. Beware that if you try to read from the
terminal when there is no input (e.g. in the end of the game or when the computer
is expecting you to print something), your solution will hang and timeout.

To read something of type a from the standard input in do-notation, use type
annotations:
	myVar <- readLn :: IO a
E.g. to read a list of Bools, use
	myBools <- readLn :: IO [Bool]

The number of attempts your solution makes to guess the sequence won’t be taken
into account but keep in mind that there are still time limits of 20 seconds
for each test. Bruteforcing up to 10^1000 combinations is probably a bad idea.

--}

solve :: IO ()
solve = undefined
