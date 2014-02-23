{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad.IO.Class
import Web.Twitter.Conduit
import System.Environment
import Common
import Control.Lens

main :: IO ()
main = withCF $ do
    [statusIdStr] <- liftIO getArgs
    let sId = read statusIdStr
    targetStatus <- call $ showId sId
    liftIO . putStrLn $ "Favorite Tweet: " ++ targetStatus ^. parsed . _Just . to show
    res <- call $ favoritesCreate sId
    liftIO $ print res
