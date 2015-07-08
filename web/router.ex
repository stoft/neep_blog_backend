defmodule NeepBlogBackend.Router do
  use NeepBlogBackend.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NeepBlogBackend do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/articles", ArticleController do
      resources "/comments", CommentController
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", NeepBlogBackend do
    pipe_through :api

    # get "/", PageController, :api
    resources "/articles", ArticleController do
      resources "/comments", CommentController
    end
  end
end
