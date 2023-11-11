module ToyGit.Tree where

import Data.ByteString (ByteString)
import ToyGit.Core (Hash)    
import ToyGit.Blob (Blob)


data TreeEntry = TreeFile Hash | TreeDirectory Tree
-- data Tree = Tree [(FilePath, TreeEntry)]
newtype Tree = Tree [(FilePath, TreeEntry)]

serializeTree :: Tree -> ByteString
serializeTree = undefined

createTree :: [(FilePath, Blob)] -> IO Tree
createTree files = undefined