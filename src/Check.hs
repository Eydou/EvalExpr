module Check (
    algoExpr,
    exitHelp,
    exitWithErrorMessage
) where

import Calculator
import Lib
import Text.Printf (printf)
import Data.Char (isDigit)
import System.Exit (exitWith, ExitCode(ExitFailure))
import System.IO (stderr, hPutStrLn)
import Data.List

exitWithErrorMessage :: String -> ExitCode -> IO a
exitWithErrorMessage str e = hPutStrLn stderr str >> exitWith e

exitHelp :: IO a
exitHelp = exitWithErrorMessage "USAGE: ./funEvalExpr [calculator]" (ExitFailure 84)

exitInfinity :: IO a
exitInfinity = exitWithErrorMessage "Error : Infinity numbers" (ExitFailure 84)

exitArgument :: IO a
exitArgument = exitWithErrorMessage "Error : Not enough or too much argument" (ExitFailure 84)

exitExpr :: IO a
exitExpr = exitWithErrorMessage "Error : Invalid argument" (ExitFailure 84)

infinity :: Double
infinity = (read "Infinity") :: Double

addingSub :: [Char] -> [Char] -> [Char]
addingSub [] [] = []
addingSub result [] = reverse result
addingSub result (x:xs)
    | x == '-' && (length result) == 0 = addingSub (['-'] ++ result) xs
    | x == '-' && xs !! 0 == '(' = addingSub (['-'] ++ result) xs
    | x == '-' && (reverse result !! ((length result) - 1)) == '(' = addingSub (['-'] ++ result) xs
    | x == '-' = addingSub (['-','+'] ++ result) xs
    | otherwise = addingSub (x : result) xs

insertAt :: a -> Int -> [a] -> [a]
insertAt newElement _ [] = [newElement]
insertAt newElement i (a:as)
    | i <= 0 = newElement:a:as
    | otherwise = a : insertAt newElement (i - 1) as

search :: (Eq a) => a -> Char -> [(a,Char)] -> Bool
search _ _ [] = False
search x d ((a,b):xs) = if x == a && d == b then True else search x d xs


parseInXs :: Int -> [Char] -> Bool
parseInXs _ [] = False
parseInXs nb str
    | nb == 1 && str !! 0 /= '-' = True
    | nb == 2 && str !! 0 == '-' = True
    | nb == 3 && str !! 0 /= '+' = True
    | nb == 4 && str !! 0 == '-' = True
    | otherwise = False

advanceParseSub :: [(Int, Char)] -> Int -> Int -> [(Int, Char)] -> [Char] -> [(Int, Char)]
advanceParseSub arr _ _ _ [] = arr
advanceParseSub arry count number result str@(x:xs)
    | x == '+' && xs !! 0 == '(' = advanceParseSub arry (count + 1) number ([(number + 1,'-')] ++ result) xs
    | x == '-' && xs !! 0 == '(' = advanceParseSub arry (count + 1) number ([(number + 1,'+')] ++ result) xs
    | x == '(' = advanceParseSub arry (count + 1) (number + 1) result xs
    | x == ')' && (search number '+' result) == True && parseInXs 1 xs == True = advanceParseSub arry (count + 1) (number - 1) (delete (number,'+') result) xs
    | x == ')' && (search number '+' result) == True && parseInXs 2 xs == True = advanceParseSub ([(count, '+')] ++ arry) (count + 1) (number - 1) (delete (number,'+') result) xs
    | x == ')' && (search number '-' result) == True && parseInXs 3 xs == True = advanceParseSub arry (count + 1) (number - 1) (delete (number,'-') result) xs
    | x == ')' && (search number '-' result) == True && parseInXs 4 xs == True = advanceParseSub ([(count, '-')] ++ arry) (count + 1) (number - 1) (delete (number,'-') result) xs
    | x == ')' = advanceParseSub arry (count + 1) (number - 1) result xs
    | otherwise = advanceParseSub arry (count + 1) number result xs

replaceElem :: Int -> a -> [a] -> [a]
replaceElem _ _ [] = []
replaceElem n elems (x:xs)
   | n == 0 = elems:xs
   | otherwise = x:replaceElem (n-1) elems xs

finalParseForSub :: [(Int, Char)] -> [Char] -> [Char]
finalParseForSub _ [] = []
finalParseForSub [] arg = arg
finalParseForSub container@(x:xs) arg
    | length container /= 0 = finalParseForSub xs (replaceElem ((fst x)+1) (snd x) arg)
    | otherwise = arg

parsingSpace :: Int -> [Char] -> Bool
parsingSpace _ [] = True
parsingSpace number (x:xs)
    | isDigit x == True && number == 0 = parsingSpace 1 xs 
    | x `elem` " \n\t" && number == 1 = parsingSpace 2 xs
    | isDigit x == True && number == 2 = False
    | otherwise = parsingSpace 0 xs

algoExpr :: [[Char]] -> IO ()
algoExpr args =
    case (fmap operator) $ parseString arithmeticExpr $ addingSub [] $ finalParseForSub (advanceParseSub [] 0 0 [] (filter (`notElem` " \n\t") (args !! 0))) (filter (`notElem` " \n\t") (args !! 0)) of
        _ | (length args) /= 1 -> exitArgument
          | parsingSpace 0 (args !! 0) == False -> exitExpr
        Just (res) | res == infinity -> exitInfinity
        Just (res) -> printf "%.2f\n" res
        Nothing -> exitExpr