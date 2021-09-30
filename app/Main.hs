module Main where

import Check (algoExpr, exitHelp)
import System.Environment (getArgs)
import System.IO ()
import qualified Control.Exception as Exc

main :: IO ()
main = getArgs >>= checkError

checkError :: [[Char]] -> IO ()
checkError args = Exc.catch (algoExpr args) check
    where
        check :: Exc.ErrorCall -> IO a
        check _ = exitHelp