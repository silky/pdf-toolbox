{-# LANGUAGE OverloadedStrings #-}

module Test.Object.Builder
(
  spec,
)
where

import Pdf.Toolbox.Core.Object.Builder

import qualified Data.ByteString.Builder as Builder
import Test.Hspec

spec :: Spec
spec = describe "Object.Builder" $ do
  buildBoolSpec
  buildStringSpec
  buildNameSpec
  buildNumberSpec

buildBoolSpec :: Spec
buildBoolSpec = describe "buildBool" $ do
  it "should build 'true' for True" $ do
    let res = buildBool True 
    Builder.toLazyByteString res `shouldBe` "true"

  it "should build 'false' for False" $ do
    let res = buildBool False
    Builder.toLazyByteString res `shouldBe` "false"

buildStringSpec :: Spec
buildStringSpec = describe "buildString" $ do
  it "should produce literal string when all chars are printable" $ do
    let res = buildString "hello"
    Builder.toLazyByteString res `shouldBe` "(hello)"

  it "should produce hex string when there are not printable chars" $ do
    let res = buildString "\NUL\255"
    Builder.toLazyByteString res `shouldBe` "<00ff>"

  it "should escape special chars" $ do
    let res = buildString "()\\"
    Builder.toLazyByteString res `shouldBe` "(\\(\\)\\\\)"

buildNameSpec :: Spec
buildNameSpec = describe "buildName" $ do
  it "should build a name" $ do
    let res = buildName "hello"
    Builder.toLazyByteString res `shouldBe` "/hello"

buildNumberSpec :: Spec
buildNumberSpec = describe "buildNumber" $ do
  it "should build int" $ do
    let res = buildNumber 42
    Builder.toLazyByteString res `shouldBe` "42"

  it "should build float" $ do
    let res = buildNumber 42.4
    Builder.toLazyByteString res `shouldBe` "42.4"
