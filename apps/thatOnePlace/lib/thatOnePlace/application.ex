defmodule ThatOnePlace.Application do
  @moduledoc """
  The ThatOnePlace Application Service.

  The thatOnePlace system business domain lives in this application.

  Exposes API to clients such as the `ThatOnePlaceWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(ThatOnePlace.Repo, []),
    ], strategy: :one_for_one, name: ThatOnePlace.Supervisor)
  end
end
