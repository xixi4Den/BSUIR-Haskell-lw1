module Args
where

import Options

data MainOptions = MainOptions
    { 
        inputPath :: String,
        clusters :: Int,
        precision :: Int,
        demension :: Int,
        separator :: String,
        ignoreFirstCol :: Bool,
        ignoreLastCol :: Bool,
        ignoreFirstLine :: Bool,
        metric :: Int,
        initAction :: Int,
        outPath :: String
    }


instance Options MainOptions where
    defineOptions = pure MainOptions
        <*> simpleOption "inputPath" ""
            "A path to input file."
        <*> simpleOption "clusters" 2
            "A number of clusters."
        <*> simpleOption "precision" 1
            "Precision for FSM algorithm."
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
        <*> simpleOption "metric" 0
            "A metric type for FSM algorithm. 0 - Euclidean. 1 - Hamming."
        <*> simpleOption "initAction" 0
            "A initial action for FSM algorithm. 0 - random matrix initialization. 1 - random choice of centers."
        <*> simpleOption "outPath" ""
            "A path to output file. Writes to the console if is empty."
