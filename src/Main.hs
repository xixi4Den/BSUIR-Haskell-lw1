--
-- Copyright (c) 2015 Denis Hihich
-- home work 1.
--
module Main
where

import Options

import Args
import CsvParser
 
main :: IO ()
main = runCommand $ \opts _ -> do
    res <- parseCsv opts 
    case res of
        Left err -> print err
        Right v -> print v