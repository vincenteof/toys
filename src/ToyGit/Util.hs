module ToyGit.Util where

import Crypto.Hash (Digest, SHA1, digestFromByteString)
import Data.ByteArray.Encoding (Base (Base16), convertFromBase, convertToBase)
import Data.ByteString (ByteString)
import ToyGit.Core (Hash)

hashToHex :: Hash -> ByteString
hashToHex = convertToBase Base16

hexToHash :: ByteString -> Maybe Hash
hexToHash hexStr = case convertFromBase Base16 hexStr :: Either String ByteString of
  Left _ -> Nothing
  Right binaryStr -> digestFromByteString binaryStr
