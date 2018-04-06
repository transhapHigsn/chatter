defmodule UserChatWeb.HelloView do
    use UserChatWeb, :view

    def render("index.json", %{}) do
        %{hello: "world"}
    end
end
