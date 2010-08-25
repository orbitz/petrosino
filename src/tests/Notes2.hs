{-# LANGUAGE DeriveDataTypeable
        , ScopedTypeVariables         #-}
 
module Main where
 
import Database.CouchDB (getDoc, newDoc, runCouchDBWith, createCouchConn, closeCouchConn, db, Rev(..), Doc)
import Data.Data (Data, Typeable)

import Data.List as List

import Text.JSON
import Text.JSON.Pretty (pp_value, render)
import Text.JSON.Generic (toJSON, fromJSON)

type Strings = [String]  -- basic
 
data Note = Note {title, text :: String, tags :: Strings}
    deriving (Eq, Ord, Show, Read , Typeable, Data)  -- not yet necessary
 
------ copied from henry laxon
 
ppJSON = putStrLn . render . pp_value
 
justDoc :: (Data a) => Maybe (Doc, Rev, JSValue) -> a
justDoc (Just (d,r,x)) = stripResult (fromJSON x)
  where stripResult (Ok z) = z
        stripResult (Error s) = error $ "JSON error " ++ s
justDoc Nothing = error "No such Document"
 
 --------------------------------
mynotes = db "firstnotes1"
 
n0 = Note "a59" "a1 text vv 45" ["tag1"]
 
n1 = Note "a56" "a1 text vv 45" ["tag1"]
n2 = Note "a56" "updated a1 text vv 45" ["tag1"]
 
documents = map toJSON [n0, n1, n2]


addNotes = do
  let notes = List.take 1000000 $ List.cycle documents
  conn <- createCouchConn "localhost" 5984
  mapM_ (\n -> runCouchDBWith conn $ newDoc mynotes n) notes
  closeCouchConn conn
  return ()

main = addNotes

-- Runtime on my MacBook Pro
-- real	64m50.508s
-- user	3m11.879s
-- sys	2m7.395s