module ToyGit.Blob where

import qualified Data.ByteString as BS
import ToyGit.Core (Content)

-- data Blob = Blob Content
newtype Blob = Blob Content

serializeBlob :: Blob -> Content
serializeBlob (Blob content) = content

createBlob :: FilePath -> IO Blob
createBlob path = Blob <$> BS.readFile path