module ToyGit.ObjectStore where

import qualified Codec.Compression.Zlib as Zlib
import Crypto.Hash (hash)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as LBS
import System.Directory (createDirectoryIfMissing, doesFileExist)
import System.FilePath (takeDirectory, (</>))
import ToyGit.Core (Content, Hash)

-- Follw what git really does, just replace `git` with `toygit`
objectStorePath :: String
objectStorePath = ".toygit/objects"

-- Compute the path of an object
-- `git` uses first two characters of the hash as the subfolder and the rest of the hash as filename
objectPath :: Hash -> FilePath
objectPath hash = objectStorePath </> take 2 hashString </> drop 2 hashString
  where
    hashString = show hash

-- `ObjectStore` acts like an kv database
-- The key is the hash of the object, and the value is the zlib-deflated content
storeObject :: Hash -> Content -> IO ()
storeObject hash content = do
  let path = objectPath hash
      compressed = Zlib.compress $ LBS.fromStrict content
  createDirectoryIfMissing True (takeDirectory path)
  LBS.writeFile path compressed

-- The retrieve process is just the opposite of the store process
retrieveObject :: Hash -> IO (Maybe Content)
retrieveObject hash = do
  let path = objectPath hash
  exists <- doesFileExist path
  if exists
    then do
      compressedContent <- LBS.readFile path
      let content = Zlib.decompress compressedContent
      return $ Just . LBS.toStrict $ content
    else return Nothing
