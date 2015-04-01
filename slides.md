# [fit] [Yesod](http://www.yesodweb.com/)
# [fit] __*or:*__ How I Learned to Stop
# [fit] Worrying and Love the Compiler

---

# Haskell

* Strongly, statically typed
* Functionally pure
* Compiled

---

^ Note: try hoogle'ing for e.g. `[a] -> Int`

# Types

```haskell
length :: [a] -> Int
sum :: [Int] -> Int
repeat :: a -> [a]
```

---

# Types

```haskell
replicate :: Int -> a -> [a]
find :: (a -> Bool) -> [a] -> Maybe a
```

---

^ Easy to reason about
^ Easy to memoize, parallelize

# Functional Purity

* Functions may be identified with their input -> output mapping
* Functions are side effect-free (can't perform IO, touch DB, `fire_missles!`, &c.)
* Everything is a function

---

# Side Effects

```haskell
distanceOfTimeInWords :: UTCTime -> UTCTime -> String
ageOfTimeInWords :: UTCTime -> IO String
```

---

# The Compiler

* You program by composing functions
* The compiler ensures that all functions compose before running anything

---

# The Compiler

Stops you from making these mistakes

```haskell
(find (> 11) [1,4,10,2,7,11]) + 1
reverse $ ageOfTimeInWords time
```

---

^ Overview of current implementation
^ - routes
^ - models
^ - handler
^ - templates
^ Mistakes you can't make
^ - n+1 query
^ - undefined template instance variable
^ - joining on wrong column
^ Add feature: show post
^ More mistakes you can't make
^ - redirecting to wrong id
^ - not escaping user input
^ Refactor: maybeize post->user

# Demo

![I've made a huge mistake](http://i.imgur.com/Aal4WRa.png)

---

# [fit] [Learn You a Haskell](http://learnyouahaskell.com/)
# [fit] Trust the Compiler
# [fit] Stop Worrying

Slides at [github.com/jamesdabbs/hello-yesod](https://github.com/jamesdabbs/hello-yesod/slides.md)
