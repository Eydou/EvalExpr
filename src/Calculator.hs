module Calculator (
    operator,
    arithmeticExpr,
    Expr(..)
) where

import Lib ( Parser, parseChar, parseDouble )
import Control.Applicative hiding (some, many)

data Expr = Num Double | Add Expr Expr | Sub Expr Expr |
 Div Expr Expr | Mul Expr Expr | Pow Expr Expr deriving (Show)

operator :: Expr -> Double
operator (Num a) = a
operator (Add a b) = operator a + operator b
operator (Sub a b) = operator a - operator b
operator (Div a b) = operator a / operator b
operator (Mul a b) = operator a * operator b
operator (Pow a b) = operator a ** operator b

arithmeticExpr :: Parser Expr
arithmeticExpr = do 
        a <- multiplication
        parseChar '+'
        b <- arithmeticExpr
        return (a `Add` b)
        <|> subtraction

subtraction :: Parser Expr
subtraction = do 
        a <- multiplication
        parseChar '-'
        b <- arithmeticExpr
        return (a `Sub` b)
        <|> multiplication

multiplication :: Parser Expr
multiplication = do
        a <- divide
        parseChar '*'
        b <- multiplication
        return (a `Mul` b)
        <|> divide

divide :: Parser Expr
divide = do
        a <- pow
        parseChar '/'
        b <- divide
        return (a `Div` b)
        <|> pow

pow :: Parser Expr
pow = do
        a <- isResult
        parseChar '^'
        b <- divide
        return (a `Pow` b)
        <|> isResult

isResult :: Parser Expr
isResult = Num <$> parseDouble <|> parens arithmeticExpr
    where
    parens parser = do
        parseChar '('
        res <- parser
        parseChar ')'
        return res