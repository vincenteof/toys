module ToyGit.Blob where

import ToyGit.Core (Hash, hashContent)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BC

newtype Blob = Blob {unBlob :: BS.ByteString}

serializeBlob :: Blob -> BS.ByteString
serializeBlob (Blob content) = header <> content
  where
    header = BC.pack $ "blob " ++ show (BS.length content) ++ "\0"

deserializeBlob :: BS.ByteString -> Blob
deserializeBlob bs = Blob $ BS.drop (headerLength bs) bs

headerLength :: BS.ByteString -> Int
headerLength bs = maybe 0 (+ 1) (BS.elemIndex 0 bs)

hashBlob :: Blob -> Hash
hashBlob = hashContent . serializeBlob