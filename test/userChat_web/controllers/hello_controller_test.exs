defmodule UserChatWeb.HelloViewTest do
    use UserChatWeb.ConnCase, async: true
    use ExUnit.Case

    test "GET /" do
        conn = get build_conn(), "/"
        assert conn.state == :sent
        assert conn.status == 200

        result = Poison.Parser.parse!(conn.resp_body, keys: :atoms!)
        assert result.hello == "world"
    end
end
