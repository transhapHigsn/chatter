defmodule UserChatWeb.VersionController do
    use UserChatWeb, :controller

    def hello(conn, _params) do
        render conn, "hello.json"
    end

    def index(conn, _params) do
        hello = [
            %{hello: "sexy",
              name: "Prashant",
              email: "test@user.com"}
        ]
        json conn, hello
    end
end
