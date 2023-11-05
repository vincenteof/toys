module ToyGit.Commit where

import ToyGit.Core (Content, Hash)
import ToyGit.Tree (Tree)

data Commit = Commit
  { commitTree :: Hash,
    commitParent :: Maybe Hash,
    commitMessage :: String
  }

serializeCommit :: Commit -> Content
serializeCommit = undefined

createCommit :: Tree -> Maybe Hash -> String -> IO Commit
createCommit = undefined