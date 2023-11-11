module ToyGit.Ref where

import Data.ByteArray.Encoding (Base (Base16), convertToBase)
import Data.ByteString (ByteString)
import qualified Data.ByteString.Char8 as BC
import System.FilePath ((</>))
import ToyGit.Core (Hash, hashContent)

updateRef :: String -> ByteString -> IO ()
updateRef refName content = BC.writeFile (refPath refName) (hashToHex $ hashContent content)

hashToHex :: Hash -> ByteString
hashToHex = convertToBase Base16

getRef :: String -> IO (Maybe Hash)
getRef refName = undefined

refPath :: String -> FilePath
refPath refName = "toygit-refs" </> refName