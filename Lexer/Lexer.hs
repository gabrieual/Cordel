module Lexer where

import Data.Char (isDigit, isAlpha, isSpace, isAlphaNum)
import Tokens

classifyIdent :: String -> Token
classifyIdent "de"       = TokIf
classifyIdent "se"       = TokIf
classifyIdent "sinão"    = TokElse
classifyIdent "enquanto" = TokWhile
classifyIdent "faça"     = TokDo
classifyIdent "em"       = TokIn
classifyIdent "poparrar" = TokBreak
classifyIdent "cabousse" = TokEnd
classifyIdent "pracada"  = TokFor
classifyIdent "devolve"  = TokReturn
classifyIdent "função"   = TokFun
classifyIdent "segue"    = TokCont
classifyIdent "então"    = TokThen
classifyIdent "e"        = TokAnd
classifyIdent "ou"       = TokOr
classifyIdent "nam"      = TokNot
classifyIdent "Certeza"  = TokBoolT
classifyIdent "Certo"    = TokBool True
classifyIdent "Errado"   = TokBool False
classifyIdent "Ruma"     = TokArray
classifyIdent "Nadica"   = TokUnit
classifyIdent "Vaique"   = TokOption
classifyIdent "Prosa"    = TokStrT
classifyIdent "Quebrado" = TokFloatT
classifyIdent "Numero"   = TokIntT
classifyIdent other      = TokIdent other


spanNum :: String -> String -> Bool -> (Token, String)
spanNum [] num float 
  | float     = ((TokFloat (read num)), "")
  | otherwise = ((TokInt (read num)), "")

spanNum (c:cs) num float
  | isDigit c                = spanNum cs (num++[c]) float
  | c == '.' && not float    = spanNum cs (num++[c]) True
  | c == '.' && float        = error ("\n\nError léxico:\nNúmero quebrado com mais de um ponto")
  | isAlpha c                = error ("\n\nError léxico:\nLetra inesperada no meio de um número: "++[c])
  | not (isDigit c) && float = ((TokFloat (read num)), (c:cs))
  | not (isDigit c)          = ((TokInt (read num)), (c:cs))
  | otherwise                = error ("\n\nError léxico:\nDigito inesperado: " ++ [c] )


lexer :: String -> [Token]
lexer [] = [TokEOF]

lexer ('#':rest) = 
  let afterComment = dropWhile (/= '\n') rest
  in lexer afterComment 

lexer ('=':'=':cs) = TokEq    : lexer cs
lexer ('>':'=':cs) = TokGe    : lexer cs
lexer ('<':'=':cs) = TokLe    : lexer cs
lexer ('-':'>':cs) = TokArrow : lexer cs

lexer ('[':cs) = TokOpenBra  : lexer cs
lexer (']':cs) = TokCloseBra : lexer cs
lexer ('=':cs) = TokAtri     : lexer cs
lexer ('>':cs) = TokGt       : lexer cs
lexer ('<':cs) = TokLt       : lexer cs
lexer ('-':cs) = TokMinus    : lexer cs
lexer ('+':cs) = TokPlus     : lexer cs
lexer ('*':cs) = TokMult     : lexer cs
lexer ('/':cs) = TokDiv      : lexer cs
lexer (',':cs) = TokComma    : lexer cs
lexer ('(':cs) = TokOpenPar  : lexer cs
lexer (')':cs) = TokClosePar : lexer cs


lexer ('"':cs) =
    let (str, rest) = span (/= '"') cs
    in case rest of
        ('"':after) -> TokStr str : lexer after
        _           -> error ("\n\nError léxico:\nString não fechada")

lexer (c:cs)
  | isSpace c = lexer cs
  | isDigit c = 
      let (token, rest) = spanNum (c:cs) "" False
      in token : lexer rest
  | isAlpha c =
      let (ident, rest) = span isAlphaNum (c:cs)
      in classifyIdent ident : lexer rest
  | otherwise = error ("\n\nError léxico:\nCharacter inesperado: " ++ [c])

