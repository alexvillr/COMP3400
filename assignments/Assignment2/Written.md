# A2 Written Components

## Question 1

First Notice, 
$$\begin{aligned}
S_n^2 & = \Big( \frac{1}{n} \sum_{k=1}^n{x^2_k}\Big) - \overline{x_n}^2\\
    n\ S_n^2 & = \sum_{k=1}^n{x_k^2} - n\ \overline{x_n}^2\\
    \sum_{k=1}^n{x_k^2} & = n\ S_n^2 + n\ \overline{x_n}^2
\end{aligned}$$

So we can then see,
$$\begin{aligned}
S_{n+1}^2 & = \Big( \frac{1}{n + 1} \sum_{k=1}^{n+1}{x_k^2} \Big) - \overline{x_{n+1}}^2\\
    & = \frac{1}{n + 1} \Big[ \sum_{k=1}^n{x_k^2} + x_{n+1}^2\Big] - \overline{x_{n+1}}^2\\
    & = \frac{1}{n + 1} \Big[ n\ S_n^2 + n\ \overline{x_n}^2 + x_{n+1}^2\Big] - \overline{x_{n+1}}^2\\
    & = \frac{n\ S_n^2 + n\ \overline{x_n}^2 + x_{n+1}^2}{n + 1} - \overline{x_{n+1}}^2\\
    & = \frac{n\ \Big(S_n^2 + \overline{x_n}^2\Big) + x_{n+1}^2}{n + 1} - \overline{x_{n+1}}^2\\
\end{aligned}$$

Hence an equation for $S_{n+1}^2$ using only $(n, S^2_n,  \bar{x}_n, \bar{x}_{n+1}, x_{n+1})$

## Question 2

```haskell
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
```

## Question 3

```haskell
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
```

## Question 4

```haskell
variance :: [Float] -> Float
variance [] = undefined
variance xs = trVariance 0 0 0 xs
```

## Question 5

__Iteration invariant:__

where ys is everything processed already and $n = \text{length } ys$
$$
\text{trVariance } n \ \overline{x} \ S^2_n \ (x:xs) = (n + 1) \ \overline{x:ys} \ S^2_{n + 1} \ xs
$$

## Question 6

__Iteration invariant proof:__

$$\begin{aligned}
\text{trVariance } n \ \overline{x} \ S^2_n \ \empty & = s\\
& = \text{variance} \ ys
\end{aligned}$$

Meaning that we have the variance of the whole list that has now been processed.

---

$$
\text{trVariance } n \ \overline{x} \ S^2_n \ (x:xs)\\
\begin{aligned}
        & = \text{trVariance } (n + 1) \ (\overline{x:ys}) \ \Big(\frac{n \times (S^2_n + \overline{x}^2) + x^2}{n + 1} - \overline{x:ys}^2\Big) \ xs\\

        & = \text{trVariance } (n + 1) \ \overline{x:ys} \ \Big(\frac{\frac{n \times \sum_{k=1}^n ys_k^2}{n} + (x^2)}{n + 1} - \overline{x:ys}^2\Big) \ xs\\

        & = \text{trVariance } (n + 1) \ \overline{x:ys} \frac{\sum_{k=1}^n ys_k^2 + x^2}{n + 1} - \overline{x:ys}^2\Big) \ xs\\

        & = \text{trVariance } (n + 1) \ \overline{x:ys} \ \Big(\frac{\sum^{n+1}_{k=1}(x:ys)_k^2}{n + 1} - \overline{x:ys}^2 \Big) \ xs\\

        & = \text{trVariance } (n + 1) \ \overline{x:ys} \ \Bigg(\Big(\frac{1}{n + 1} \times \sum_{k=1}^{n+1} (x:ys)_k^2\Big) - \overline{x:ys}^2 \Bigg) \ xs\\

        & = \text{trVariance } (n + 1) \ \overline{x:ys} \ S^2_{n+1} \ xs
\end{aligned}$$

Meaning that we have the variance of (ys:x) and will continue to process with the rest of the list that hasn't been processed yet.

---

$$
\text{trVariance } 0\ 0\ 0\ (x:xs)\\
\begin{aligned}
        & = \text{trVariance } (0 + 1)\ \overline{x}\ \Big(\frac{0 \times (0 + 0^2) + x^2)}{1} - \overline{x}^2\Big)\ xs \\
        & = \text{trVariance } 1\ \overline{x}\ \Big(\frac{x^2}{1} - \overline{x}^2\Big)\ xs\\
        & = \text{trVariance } 1\ x\ 0\ xs\\
        & = \text{trVariance } 1\ \overline{x}\ (\text{variance } x)\ xs
\end{aligned}$$

Meaning that the first call will always return a variance of 0 which is correct for the variance of 1 value.

And thus we have our formula for variance to satisfy our iteration invariant for a base case, a recursive case, and our final (edge) case

## Question 7

__Bound Value:__

Our bound value would be the length of our input list xs

## Question 8

__Decreasing and positivity of bound value:__

each time we take an element out of xs and process it so each iteration shortens the length of the list. The length will always be positive because our function can never be called on an empty list, and once we run out of elements in the list we return and finish. Thus we have a value which is always positive and decreases every iteration down to zero.

## Question 9

__Quick Checks:__

```haskell
-- Var(X) > 0
property1 :: IO()
property1 = quickCheck $ \xs -> null xs || variance xs >= 0

-- Var(X + c) = Var(X), where c is some constant.
property2 :: IO()
property2 = quickCheck $ \a xs -> null xs || abs (variance (map (+ a) xs) - variance xs) < 10**(-2)

-- Var(aX) = a^2 * Var(X), where a is some constant.
property3 :: IO()
property3 = quickCheck $ \a xs -> null xs || abs (variance (map (a *) xs) - ((a ** 2) * variance xs)) < 10**(-2)

-- Var(aX + b) = a^2 * Var(X), the result of the previous two properties combined.
property4 :: IO()
property4 = quickCheck $ \a b xs -> null xs || abs (variance (map (\x -> a * x + b) xs) - ((a ** 2) * variance xs)) < 10**(-2)
```

These are based on the properties of population variance.

The first property of variance is that variance will always be a positive number.

The second property of variance is that if you add some constant to every value in the list, the variance does not change.

The third property of variance is that if you multiply some constant with every value in the list, the variance is the same as if you didn't do that multiplication and then multiplied the result by the constant squared.

The final property is that the second and third property can be combined.

## Question 10
