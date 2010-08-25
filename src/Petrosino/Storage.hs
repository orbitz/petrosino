{-# LANGUAGE DeriveDataTypeable
  , ScopedTypeVariables #-}
 
module Petrosino.Storage (newRule)

where

import Database.CouchDB ( getDoc
                        , newDoc
                        , runCouchDBWith
                        , createCouchConn
                        , closeCouchConn
                        , db
                        , Rev(..)
                        , Doc
                        , CouchConn
                        , CouchMonad
                        )

import Data.Data (Data, Typeable)

import Text.JSON (Result(..))

import Text.JSON.Pretty (pp_value, render)
import Text.JSON.Generic (toJSON, fromJSON)

import Petrosino.Rule (Rule, DrinkAmount(..))

data RuleDoc = RuleDoc { rule :: Rule
                       , count :: Int
                       }
             deriving (Eq, Ord, Show, Read, Typeable, Data)

petrosinoDB = db "petrosino"

newRule :: Rule -> CouchMonad (Doc, Rev)
newRule rule = newDoc petrosinoDB $ toJSON $ RuleDoc { rule=rule, count=0 }
