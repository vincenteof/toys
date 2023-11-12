module ToyGit.Ref where

import Data.ByteString (ByteString)
import qualified Data.ByteString.Char8 as BC
import System.FilePath ((</>))
import ToyGit.Core (Hash, hashContent)
import ToyGit.Util (hashToHex)

updateRef :: String -> ByteString -> IO ()
updateRef refName content = BC.writeFile (refPath refName) (hashToHex $ hashContent content)

getRef :: String -> IO (Maybe Hash)
getRef refName = undefined

refPath :: String -> FilePath
refPath refName = "toygit-refs" </> refName