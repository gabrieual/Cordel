module Tokens where

data Token
    = TokInt Int
    | TokFloat Double
    | TokIdent String
    | TokStr String
    | TokBool Bool
    | TokIntT
    | TokFloatT
    | TokStrT
    | TokBoolT
    | TokArray
    | TokOpenPar
    | TokClosePar
    | TokEnd
    | TokIf
    | TokThen
    | TokFor
    | TokIn
    | TokDo
    | TokElse
    | TokCont
    | TokWhile
    | TokBreak
    | TokFun 
    | TokAnd
    | TokOr
    | TokNot
    | TokOption
    | TokUnit
    | TokOpen
    | Tokcomma 
    | TokReturn
    | TokArrow
    | TokEq
    | TokAtri 
    | TokPlus
    | TokMinus 
    | TokDiv
    | TokMult
    | TokLe 
    | TokLt 
    | TokGe 
    | TokGt
    | TokEOF
    | TokError
    deriving (Show, Eq)
