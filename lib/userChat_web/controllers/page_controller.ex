defmodule UserChatWeb.PageController do
  use UserChatWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, params) do
    changeset = UserChat.ChatUser.changeset(%UserChat.ChatUser{}, params)
    case changeset do
        {:ok, _user} -> true
        {:error, _changeset} -> false
    end
    user = UserChat.ChatUser.new(changeset)
    render conn, "user.json",
           %{token: Phoenix.Token.sign(conn, "user salt", user.id), user: user}
  end
end
