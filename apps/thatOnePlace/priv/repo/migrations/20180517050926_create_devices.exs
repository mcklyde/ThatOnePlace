defmodule ThatOnePlace.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :lastRequest, :utc_datetime
      add :deviceIdentifier, :uuid

      timestamps()
    end

    create unique_index(:devices, [:deviceIdentifier])
  end
end
