--
-- Copyright (c) 2015 Denis Hihich
-- home work 1.
--
module Main
where

import Options
import Args

 
main :: IO ()
main = runCommand $ \opts args -> do
    putStrLn (inputPath opts)