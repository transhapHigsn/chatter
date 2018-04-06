defmodule UserChatWeb.HelloController do
    use UserChatWeb, :controller

    def index(conn, _param) do
        render conn, "index.json"
    end
end
