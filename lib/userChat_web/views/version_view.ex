defmodule UserChatWeb.VersionView do
    use UserChatWeb, :view

    def render("hello.json", %{}) do
        %{hey: "sexy"}
    end
end
