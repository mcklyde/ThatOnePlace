defmodule ThatOnePlace.ThatOnePlaceWeb.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "devices" do
    field :deviceIdentifier, Ecto.UUID
    field :lastRequest, :time

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:lastRequest, :deviceIdentifier])
    |> validate_required([:deviceIdentifier])
    |> unique_constraint(:deviceIdentifier)
  end
end
