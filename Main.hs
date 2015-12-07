--
-- Copyright (c) 2015 Denis Hihich
-- home work 1.
--
import System.Environment
 
main :: IO ()
main = getArgs >>= print . haqify . head
 
haqify s = "Haq! " ++ s