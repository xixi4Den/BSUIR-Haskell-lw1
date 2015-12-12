module FCM
where

import System.Random
import Data.List

import Args

classify :: StdGen -> ProgramOptions -> [[Double]] -> [[Double]]
classify gen options patterns = classifyInternal (precision options) (initAccum gen (startWithRandomVector options) options patterns) (distanceMethod (distance options)) patterns
    where initAccum gen True options patterns = calculateNextAccum (generateRandom2dList gen (clusters options) (demension options)) patterns (distanceMethod (distance options))
          initAccum gen False options patterns = generateRandom2dList gen (clusters options) $ length patterns
          distanceMethod 0 = euclideanDistance
          distanceMethod 1 = hammingDistance


classifyInternal :: Double -> [[Double]] -> ([Double] -> [Double] -> Double) -> [[Double]] -> [[Double]]
classifyInternal precision accum distanceMethod patterns = if getNorma nextAccum accum <= precision 
    then accum 
    else classifyInternal precision nextAccum distanceMethod patterns
    where nextAccum = calculateNextAccum (findNewCenters accum patterns) patterns distanceMethod


generateRandom2dList :: RandomGen g => g -> Int -> Int -> [[Double]]
generateRandom2dList g clusterCount patternCount = normalize $ splitTo2d clusterCount $ randomList g 0 1000 $ clusterCount * patternCount
    where randomList g minN maxM count = take count $ randomRs (minN, maxM) g
          splitTo2d _ [] = []
          splitTo2d demension list = (take demension list):(splitTo2d demension $ drop demension list) 
          normalize list = map (\x -> map (\y -> y / sum x) x) list


findNewCenters :: [[Double]] -> [[Double]] -> [[Double]]
findNewCenters accum patterns = map (\accumCol -> findNewCenter accumCol patterns) $ transpose accum
    where findNewCenter accumCol patterns = map (\pattern -> findNewCenterI accumCol pattern) $ transpose patterns
          findNewCenterI accumCol pattern = sum (zipWith (*) (map (**2) accumCol) pattern) / sum accumCol


calculateNextAccum :: [[Double]] -> [[Double]] -> ([Double] -> [Double] -> Double) -> [[Double]]
calculateNextAccum centers patterns distanceMethod = map (\pattern -> findNewAccumRow centers pattern) patterns
    where findNewAccumRow centers pattern = map (\center -> findNewAccumEl center pattern centers) centers
          findNewAccumEl center pattern centers =  (1/) $ sum $ map (\otherCenter -> (summand center otherCenter pattern)) $ centers
          without element list = filter (/=element) list
          summand center otherCenter pattern = ((distanceMethod center pattern) / (distanceMethod otherCenter pattern)) ** 2


getNorma :: [[Double]] -> [[Double]] -> Double
getNorma a b = maximum $ zipWith (\ai bi -> abs (ai - bi)) (concat a) (concat b)


euclideanDistance :: [Double] -> [Double] -> Double
euclideanDistance a b = sqrt $ sum $ zipWith (\ai bi -> (ai - bi)**2) a b


hammingDistance :: [Double] -> [Double] -> Double
hammingDistance a b = sum $ zipWith (\ai bi -> abs (ai - bi)) a b