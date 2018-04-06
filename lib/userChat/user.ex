defmodule UserChat.ChatUser do
  use Ecto.Schema
  import Ecto.Changeset
  require Ecto.Query

  schema "chatusers" do
      field :email, :string
      field :mobile, :string
      field :name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :mobile, :name])
    |> validate_required([:email, :mobile, :name])
  end

  def new(user) do
      UserChat.Repo.insert(user)
  end

  def get(email) do
      query = UserChat.ChatUser |> Ecto.Query.where(email: ^email)
      case UserChat.Repo.one(query) do
          nil -> {:error, %{message: "No record matching"}}
          user -> {:ok, user}
      end
  end
end
