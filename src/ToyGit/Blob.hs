module ToyGit.Blob where

import qualified Data.ByteString as BS

-- data Blob = Blob Content
newtype Blob = Blob BS.ByteString

serializeBlob :: Blob -> BS.ByteString
serializeBlob (Blob content) = content

createBlob :: FilePath -> IO Blob
createBlob path = Blob <$> BS.readFile path