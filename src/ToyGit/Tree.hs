{-# LANGUAGE OverloadedStrings #-}

module ToyGit.Tree where

import qualified Data.ByteArray.Encoding as BA (Base (Base16), convertToBase)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BC
import qualified Data.Map as Map
import ToyGit.Blob (Blob)
import ToyGit.Core (Hash, hashContent)

data TreeEntry
  = TreeFile FilePath Hash
  | TreeDirectory FilePath Tree
  deriving (Show, Eq)

newtype Tree = Tree {unTree :: Map.Map FilePath TreeEntry}
  deriving (Show, Eq)

serializeTree :: Tree -> BS.ByteString
serializeTree (Tree entries) = BS.concat . Map.elems $ Map.mapWithKey serializeEntry entries

serializeEntry :: FilePath -> TreeEntry -> BS.ByteString
serializeEntry path (TreeFile _ hash) = BS.concat ["100644 blob ", hashToDex hash, "\0", BC.pack path]
  where
    hashToDex = BA.convertToBase BA.Base16
serializeEntry path (TreeDirectory _ tree) = serializeTree tree

hashTree :: Tree -> Hash
hashTree = hashContent . serializeTree