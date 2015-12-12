module Args
where

import Options

data ProgramOptions = ProgramOptions
    { 
        inputPath :: String,
        clusters :: Int,
        precision :: Double,
        demension :: Int,
        separator :: String,
        ignoreFirstCol :: Bool,
        ignoreLastCol :: Bool,
        ignoreFirstLine :: Bool,
        distance :: Int,
        startWithRandomVector :: Bool,
        outPath :: String
    }


instance Options ProgramOptions where
    defineOptions = pure ProgramOptions
        <*> simpleOption "inputPath" ""
            "A path to input file."
        <*> simpleOption "clusters" 2
            "A number of clusters."
        <*> simpleOption "precision" 1
            "Precision for FCM algorithm."
        <*> simpleOption "demension" 2
            "A demension of the feature vector"
        <*> simpleOption "separator" ","
            "A separator of the csv file"
        <*> simpleOption "ignoreFirstCol" False
            "The csv parser should ignore the first column."
        <*> simpleOption "ignoreLastCol" False
            "The csv parser should ignore the last column."
        <*> simpleOption "ignoreFirstLine" False
            "The csv parser should ignore the first line."
        <*> simpleOption "distance" 0
            "A distance type for FCM algorithm. 0 - Euclidean. 1 - Hamming."
        <*> simpleOption "startWithRandomVector" False
            "A initial action for FCM algorithm. False - random matrix initialization. True - random choice of centers."
        <*> simpleOption "outPath" ""
            "A path to output file. Writes to the console if is empty."