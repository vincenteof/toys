module ToyGit.ObjectStore where
import ToyGit.Core (Hash, Content)
import qualified Data.ByteString as BS


storeObject :: Hash -> Content -> IO ()
storeObject hash content = undefined

retrieveObject :: Hash -> IO Content
retrieveObject hash = undefined