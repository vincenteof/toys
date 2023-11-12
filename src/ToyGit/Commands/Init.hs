module ToyGit.Commands.Init where

import Control.Monad (unless)
import System.Directory (createDirectoryIfMissing, doesDirectoryExist)
import System.FilePath ((</>))

initRepo :: FilePath -> IO ()
initRepo repoPath = do
  let gitDir = repoPath </> ".toygit"
  let objectsDir = gitDir </> "objects"
  let refsDir = gitDir </> "refs"
  let headsDir = refsDir </> "heads"
  let tagsDir = refsDir </> "tags"
  repoExists <- doesDirectoryExist gitDir
  unless repoExists $ do
    mapM_ (createDirectoryIfMissing True) [gitDir, objectsDir, headsDir, tagsDir]
    writeFile (gitDir </> "HEAD") "ref: refs/heads/master\n"
    putStrLn "Initialized empty toygit repository"