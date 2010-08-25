{-# LANGUAGE DeriveDataTypeable
  , ScopedTypeVariables #-}

module Petrosino.Rule (Rule(..), DrinkAmount(..)) 

where

import Data.Data (Data, Typeable)

data DrinkAmount = SipDrink | HalfDrink | WholeDrink
                   deriving (Eq, Ord, Show, Read, Data, Typeable)

data Rule = Rule { rule :: String
                 , drink :: DrinkAmount
                 }
          deriving (Eq, Ord, Show, Read, Data, Typeable)
