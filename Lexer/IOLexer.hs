module Main where

import qualified Data.Text.Lazy as TL
import qualified Data.Text.Lazy.IO as TLIO
import System.Environment (getArgs)
import Lexer

main :: IO ()
main = do
    args <- getArgs
    case args of 
        []           -> putStrLn "Nenhum caminho para arquivo foi passado"
        (fileName:_) -> do
            rawContent <- TLIO.readFile fileName
            let content = TL.unpack rawContent
            let tokens = lexer content
            print tokens
    