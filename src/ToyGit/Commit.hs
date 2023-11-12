module ToyGit.Commit where

import Data.ByteString (ByteString)
import qualified Data.ByteString.Char8 as BC
import Data.Time.Clock (UTCTime)
import Data.Time.Format (defaultTimeLocale, formatTime)
import ToyGit.Core (Hash, hashContent)
import ToyGit.Tree (Tree)

data Commit = Commit
  { commitTree :: Hash,
    commitParents :: [Hash],
    commitAuthor :: String,
    commitCommitter :: String,
    commitMessage :: String,
    commitTime :: UTCTime
  }
  deriving (Show, Eq)

serializeCommit :: Commit -> ByteString
serializeCommit commit =
  BC.pack $
    unlines
      [ "tree " ++ show (commitTree commit),
        unlines $ map (("parent " ++) . show) (commitParents commit),
        "author " ++ commitAuthor commit,
        "committer " ++ commitCommitter commit,
        "",
        commitMessage commit
      ]
  where
    formatTimeStr = formatTime defaultTimeLocale "%Y-%m-%dT%H:%M:%SZ"
    formattedTime = formatTimeStr (commitTime commit)

hashCommit :: Commit -> Hash
hashCommit = hashContent . serializeCommit