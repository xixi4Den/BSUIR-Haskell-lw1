--
-- Copyright (c) 2015 Denis Hihich
-- home work 1.
--
module Main
where

import Options
import System.Random

import Args
import CsvParser
import FCM
 
main :: IO ()
main = runCommand $ \opts _ -> do
    res <- parseCsv opts 
    stdGen <- getStdGen
    case res of
        Left err -> print err
        Right patterns -> do
            writeCsv opts $ classify stdGen opts patterns
