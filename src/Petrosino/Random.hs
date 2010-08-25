module Petrosino.Random (randomSample) 

where

import Data.List ((!!), (++), splitAt)
import System.Random (getStdRandom, randomR)



removeIndex idx l = case splitAt idx l of
                      (b, _:e) -> b ++ e
                      _ -> error "Bad index or something"

-- This looks alittle too imperative...?
randomSample' :: Int -> [a] -> [a] -> IO [a]
randomSample' 0 _inp outp = return outp
randomSample' n inp outp = do 
  r <- getStdRandom (randomR (0, (length inp) - 1))
  randomSample' (n - 1) (removeIndex r inp) ((inp !! r):outp)

randomSample :: Int -> [a] -> IO [a]
randomSample n l = randomSample' n l []
