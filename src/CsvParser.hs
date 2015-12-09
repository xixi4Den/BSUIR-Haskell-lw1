module CsvParser
where

import Data.Csv
import qualified Data.ByteString.Lazy as BS
import qualified Data.Vector as V
import Data.Char

import Args

parseCsv :: ProgramOptions -> IO (Either String [[Double]])
parseCsv options = do
    csvData <- BS.readFile $ inputPath options
    case decodeWith decodeOptions ignoreHeader csvData :: Either String (V.Vector(V.Vector String)) of
        Left err -> return $ Left err
        Right vv -> do
            return $ Right $ map (\l -> castRowToDouble $ filterColumns (ignoreFirstCol options) (ignoreLastCol options) l) ll
            where ll = V.toList $ V.map (V.toList) vv
        where decodeOptions = DecodeOptions {
                decDelimiter = fromIntegral . ord . head $ separator options}
              ignoreHeader = if ignoreFirstLine options then HasHeader else NoHeader
  
filterColumns :: Bool -> Bool -> [String] -> [String]
filterColumns True True (_:xs) = init xs   
filterColumns True False (_:xs) = xs  
filterColumns False True x =  init x             
filterColumns False False x = x

castRowToDouble :: [String] -> [Double]
castRowToDouble s = map (\i -> read i :: Double) s