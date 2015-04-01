module Handler.Home where

-- The default import includes a few functions (from Persistent) that conflict with Esqueleto
import Import hiding ((==.), on, Value)
import Yesod.Form.Bootstrap3

import Database.Esqueleto


postForm :: UserId -> UTCTime -> Form Post
postForm userId now = renderBootstrap3 layout $ Post
  <$> areq textField "Title" Nothing
  <*> areq textareaField "Body" Nothing
  <*> pure userId
  <*> pure now
    where
      layout = BootstrapHorizontalForm
        { bflLabelOffset = ColMd 0
        , bflLabelSize = ColMd 3
        , bflInputOffset = ColMd 0
        , bflInputSize = ColMd 6
        }


getHomeR :: Handler Html
getHomeR = do
  posts <- runDB postsWithUserData
  defaultLayout $ do
    setTitle "Welcome To Yesod!"
    $(widgetFile "homepage")
  where
    postsWithUserData = select $
      from $ \(post `InnerJoin` author) -> do
        on $ post ^. PostAuthorId ==. author ^. UserId
        return
          ( post ^. PostId
          , post ^. PostTitle
          , post ^. PostPublishedAt
          , author ^. UserIdent
          )


getNewPostR :: Handler Html
getNewPostR = do
  userId <- requireAuthId
  now <- liftIO getCurrentTime
  (formWidget, formEnctype) <- generateFormPost $ postForm userId now
  defaultLayout $ do
    setTitle "New Post"
    $(widgetFile "posts/new")


postPostsR :: Handler Html
postPostsR = do
  userId <- requireAuthId
  now <- liftIO getCurrentTime
  ((result, formWidget), formEnctype) <- runFormPost $ postForm userId now
  case result of
    FormSuccess post -> do
      postId <- runDB $ insert post
      setMessage "Post created"
      redirect HomeR
    _ -> defaultLayout $ do
        setTitle "New Post"
        $(widgetFile "posts/new")
