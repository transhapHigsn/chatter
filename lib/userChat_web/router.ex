defmodule UserChatWeb.Router do
  use UserChatWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", UserChatWeb do
    pipe_through :browser

    # get "/", HelloController, :index
    get "/", PageController, :index
  end

  scope "/v1", UserChatWeb do
    pipe_through :api

     get "/", VersionController, :index
     get "/hello", VersionController, :hello
  end
end
