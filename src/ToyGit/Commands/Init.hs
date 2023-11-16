module ToyGit.Commands.Init where

import Control.Monad (unless)
import System.Directory (createDirectoryIfMissing, doesDirectoryExist)
import System.FilePath ((</>))
import ToyGit.Index (initIndex, saveIndex)

initRepo :: FilePath -> IO ()
initRepo repoPath = do
  let gitDir = repoPath </> ".toygit"
  let objectsDir = gitDir </> "objects"
  let refsDir = gitDir </> "refs"
  let headsDir = refsDir </> "heads"
  let tagsDir = refsDir </> "tags"
  let indexPath = gitDir </> "index"
  repoExists <- doesDirectoryExist gitDir
  unless repoExists $ do
    mapM_ (createDirectoryIfMissing True) [gitDir, objectsDir, headsDir, tagsDir]
    saveIndex indexPath initIndex
    writeFile (gitDir </> "HEAD") "ref: refs/heads/main\n"
    putStrLn "Initialized empty toygit repository"