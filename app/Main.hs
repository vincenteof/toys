module Main where

import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  case args of
    ["add", file] -> putStrLn "add file"
    ["commit", message] -> putStrLn "commit"
    ["checkout", branch] -> putStrLn "checkout"
    _ -> putStrLn "Unknown command"
