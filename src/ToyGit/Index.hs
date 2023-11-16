{-# LANGUAGE OverloadedStrings #-}

module ToyGit.Index where

import qualified Data.ByteString.Char8 as BC
import qualified Data.Map as Map
import Data.Maybe (catMaybes)
import Data.Time.Clock (UTCTime)
import Data.Time.Format (defaultTimeLocale, formatTime, parseTimeM)
import System.Directory (doesFileExist)
import System.IO (IOMode (ReadMode, WriteMode), withFile)
import ToyGit.Core (Hash)
import ToyGit.Util (hashToHex, hexToHash)

-- TODO: This definition lacks many fields for real git implementation
data IndexEntry = IndexEntry
  { indexPath :: FilePath,
    indexHash :: Hash
  }
  deriving (Eq, Show)

type Index = Map.Map FilePath IndexEntry


initIndex :: Index
initIndex = Map.empty

saveIndex :: FilePath -> Index -> IO ()
saveIndex indexPath index = withFile indexPath WriteMode $ \handle -> do
  let serialize (path, IndexEntry _ hash) = BC.concat [BC.pack path, " ", hashToHex hash, "\n"]
  mapM_ (BC.hPut handle . serialize) (Map.toList index)

loadIndex :: FilePath -> IO Index
loadIndex indexPath = do
  exists <- doesFileExist indexPath
  if exists
    then withFile indexPath ReadMode $ \handle -> do
      contents <- BC.hGetContents handle
      let entries = map parseLine . BC.lines $ contents
      return $ Map.fromList $ catMaybes entries
    else return Map.empty
  where
    parseLine :: BC.ByteString -> Maybe (FilePath, IndexEntry)
    parseLine line = case BC.words line of
      [path, hashStr] -> do
        hash <- hexToHash hashStr
        return (BC.unpack path, IndexEntry (BC.unpack path) hash)
      _ -> Nothing
