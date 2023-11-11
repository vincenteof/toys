module ToyGit.Core where

import Crypto.Hash (Digest, SHA1, hash)
import Data.ByteString (ByteString)

type Hash = Digest SHA1

hashContent :: ByteString -> Hash
hashContent = hash