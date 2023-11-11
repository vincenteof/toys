module ToyGit.Commit where

import Data.ByteString (ByteString)
import ToyGit.Core (Hash)
import ToyGit.Tree (Tree)

data Commit = Commit
  { commitTree :: Hash,
    commitParent :: Maybe Hash,
    commitMessage :: String
  }

serializeCommit :: Commit -> ByteString
serializeCommit = undefined

createCommit :: Tree -> Maybe Hash -> String -> IO Commit
createCommit = undefined