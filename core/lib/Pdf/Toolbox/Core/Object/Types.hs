{-# LANGUAGE GeneralizedNewtypeDeriving #-}

-- | Module contains definitions of pdf objects
--
-- See PDF1.7:7.3

module Pdf.Toolbox.Core.Object.Types
(
  Object(..),
  Name,
  Dict(..),
  Array(..),
  Stream(..),
  Ref(..)
)
where

import Pdf.Toolbox.Core.Name (Name)

import Data.ByteString (ByteString)
import Data.Scientific (Scientific)

-- | Set of key/value pairs
newtype Dict = Dict [(Name, Object ())]
  deriving (Eq, Show)

-- | An array
newtype Array = Array [Object ()]
  deriving (Eq, Show)

-- | Contains stream dictionary and a payload
--
-- The payload could be offset within pdf file, actual content,
-- content stream or nothing
data Stream a = Stream Dict a
  deriving (Eq, Show)

-- | Object reference, contains object index and generation
data Ref = Ref Int Int
  deriving (Eq, Show, Ord)

-- | Any pdf object
--
-- It is parameterized by 'Stream' content
data Object a =
  ONumber Scientific |
  OBoolean Bool |
  OName Name |
  ODict Dict |
  OArray Array |
  OStr ByteString |
  OStream (Stream a) |
  ORef Ref |
  ONull
  deriving (Eq, Show)
