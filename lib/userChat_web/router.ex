defmodule UserChatWeb.Router do
  use UserChatWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_user_token
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  defp put_user_token(conn, _) do
    if current_user = conn.assigns[:current_user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end

  scope "/", UserChatWeb do
    pipe_through :browser

    # get "/", HelloController, :index
    get "/", PageController, :index
    get "/create", PageController, :create
  end

  scope "/v1", UserChatWeb do
    pipe_through :api

     get "/", VersionController, :index
     get "/hello", VersionController, :hello
  end
end
