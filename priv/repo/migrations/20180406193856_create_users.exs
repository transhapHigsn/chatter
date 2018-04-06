defmodule UserChat.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:chatusers) do
      add :name, :string
      add :email, :string
      add :mobile, :string

      timestamps()
    end
  end
end
