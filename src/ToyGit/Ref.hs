module ToyGit.Ref where

import qualified Data.ByteString.Char8 as BC
import System.Directory (createDirectoryIfMissing, doesFileExist)
import System.FilePath ((</>))
import System.FilePath.Posix (takeDirectory)
import ToyGit.Core (Hash, hashContent)

writeRef :: FilePath -> String -> Hash -> IO ()
writeRef repoPath refName hash = do
  let refPath = getRefPath repoPath refName
  createDirectoryIfMissing True (takeDirectory refPath)
  BC.writeFile refPath (BC.pack $ show hash)

readRef :: FilePath -> String -> IO (Maybe Hash)
readRef repoPath refName = do
  let refPath = getRefPath repoPath refName
  exists <- doesFileExist refPath
  if exists
    then Just . read . BC.unpack <$> BC.readFile refPath
    else return Nothing

getRefPath :: FilePath -> String -> FilePath
getRefPath repoPath refName = repoPath <> ".toygit" </> "refs" </> "heads" </> refName
