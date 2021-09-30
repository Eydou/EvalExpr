module Lib (
    parseChar,
    parseDouble,
    parseString,
    Parser(..)
) where

import Control.Applicative hiding (some, many)
data Parser a = Parser {
    runParser :: String -> Maybe (a , String)
}

instance Functor Parser where
    fmap fct parser = Parser $ \ str -> case runParser parser str of
        Just (res, sstr) -> Just (fct res, sstr)
        Nothing -> Nothing

instance Applicative Parser where
    pure x = Parser $ \str -> Just (x, str)
    parser1 <*> parser2 = Parser $ \ str -> case runParser parser1 str of
        Just (res1, str1) -> case runParser parser2 str1 of
            Just (res2, str2) -> Just (res1 res2, str2)
            Nothing -> Nothing
        Nothing -> Nothing
    parser1 *> parser2 = (\ _ -> (\ x -> x)) <$> parser1 <*> parser2
    parser1 <* parser2 = (\ a -> (\ _ -> a)) <$> parser1 <*> parser2

instance Alternative Parser where
    empty = Parser $ (\ a -> (\ _ -> a)) Nothing
    (Parser parser1) <|> (Parser parser2) = Parser $ \ str -> case str of
        _ -> case parser1 str of
            Just _ -> parser1 str
            Nothing -> parser2 str

instance Monad Parser where
    return res = Parser $ \str -> Just (res, str)
    parse >>= func = Parser $ (\str -> case runParser parse str of
        Nothing -> Nothing
        Just (res, output) -> runParser (func res) output)

parseChar :: Char -> Parser Char
parseChar c = Parser $ \ str -> case str of
    "" -> Nothing
    (char:xstr) -> if char == c then Just (c, xstr) else Nothing

parseAnyChar :: String -> Parser Char
parseAnyChar "" = Parser $ \_ -> Nothing
parseAnyChar (c:xstr) = Parser $ \str -> case str of
    "" -> Nothing
    _ -> case runParser (parseChar c) str of
        Just (char, lastStr) -> Just (char, lastStr)
        Nothing -> runParser (parseAnyChar xstr) str

parseOr :: Parser a -> Parser a -> Parser a
parseOr (Parser func1) (Parser func2) = Parser $ \ str -> func1 str <|> func2 str

parseAnd :: Parser a -> Parser b -> Parser (a, b)
parseAnd (Parser func1) (Parser func2) = Parser $ \ str -> case func1 str of
    Just (ffunc, s) -> case func2 s of
        Just (ffunc2, lastString) -> Just ((ffunc, ffunc2), lastString)
        Nothing -> Nothing
    Nothing -> Nothing

parseAndWith :: (a -> b -> c) -> Parser a -> Parser b -> Parser c
parseAndWith f (Parser func1) (Parser func2) = Parser $ \ str -> case func1 str of
    Just (ffunc1, str1) -> case func2 str1 of
        Just (ffunc2, str2) -> Just (f ffunc1 ffunc2, str2)
        Nothing -> Nothing
    Nothing -> Nothing

parseMany :: Parser a -> Parser [a]
parseMany (Parser func) = Parser $ \ str -> case func str of
    Just (func1, str1) -> case runParser (parseMany $ Parser $ func) str1 of
       Just (func2, str2) -> Just (func1:func2, str2)
       Nothing -> Just ([func1], str1)
    Nothing -> Just ([], str)

parseSome :: Parser a -> Parser [a]
parseSome (Parser func) = Parser $ \ str -> case func str of 
    Just (func1, fstr) -> case runParser (parseMany $ Parser $ func) fstr of
       Just (func2, sstr) -> Just (func1:func2, sstr)
       Nothing -> Just ([func1], fstr)
    Nothing -> Nothing

parseDouble :: Parser Double
parseDouble = Parser $ \ str -> case runParser ((parseChar '-') *> (parseSome $ parseAnyChar "0123456789.")) str of
    Just (result,string) | (result !! 0) == '.' -> Just (- (read (tail result) :: Double) / (10 ** (fromIntegral (length (tail result)) :: Double)), string)
    Just (result,string) | (result !! ((length result) - 1)) == '.' -> Just (- read (init result) :: Double, string)
    Just (result,string) -> Just (- read result :: Double, string)
    Nothing -> case runParser (parseSome $ parseAnyChar "0123456789.") str of
        Just (result,string) | (result !! 0) == '.' -> Just ((read (tail result) :: Double) / (10 ** (fromIntegral (length (tail result)) :: Double)), string)
        Just (result,string) | (result !! ((length result) - 1)) == '.' -> Just (read (init result) :: Double, string)
        Just (result,string) -> Just (read result :: Double, string)
        Nothing -> Nothing

parseString :: Parser a -> String -> Maybe a
parseString (Parser parser) str = case parser str of
    Just (res, "") -> Just res
    _ -> Nothing