defmodule UserChatWeb.PageController do
  use UserChatWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
