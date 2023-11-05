module ToyGit.Tree where

import ToyGit.Core (Hash, Content)    
import ToyGit.Blob (Blob)


data TreeEntry = TreeFile Hash | TreeDirectory Tree
-- data Tree = Tree [(FilePath, TreeEntry)]
newtype Tree = Tree [(FilePath, TreeEntry)]

serializeTree :: Tree -> Content
serializeTree = undefined

createTree :: [(FilePath, Blob)] -> IO Tree
createTree files = undefined