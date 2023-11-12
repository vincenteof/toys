module ToyGit.Util where

import Data.ByteArray.Encoding (Base (Base16), convertToBase)
import Data.ByteString (ByteString)
import ToyGit.Core (Hash)

hashToHex :: Hash -> ByteString
hashToHex = convertToBase Base16