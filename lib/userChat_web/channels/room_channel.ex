defmodule UserChatWeb.RoomChannel do
  use UserChatWeb, :channel

  def join("room:lobby", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    user = %{name: payload[:name],
             email: payload[:email],
             mobile: payload[:mobile]}
    user_changeset = UserChat.ChatUser.changeset(%UserChat.ChatUser{}, user)
    UserChat.ChatUser.new(user_changeset)
    broadcast socket, "ping", payload
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  def handle_in("shout", payload, socket) do
    UserChat.Message.changeset(%UserChat.Message{}, payload)
    |> UserChat.Repo.insert
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("exit", payload, socket) do
    broadcast_from socket, "leaving", payload
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    broadcast_from socket, "welcome", %{}
    UserChat.Message.get_messages()
    |> Enum.each(fn msg -> push(socket, "shout", %{
        name: msg.name,
        message: msg.message,
      }) end)
    {:noreply, socket} # :noreply
  end

  def leave(%{}, socket) do
      broadcast socket, "bye", %{}
      {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(payload) do
      email = payload["email"]
      IO.puts("Email #{email}" )
      case UserChat.ChatUser.get(email) do
          {:ok, _user} -> true
          {:error, _resp} ->
              IO.puts("unauthorized access")
              false
      end
  end
end
