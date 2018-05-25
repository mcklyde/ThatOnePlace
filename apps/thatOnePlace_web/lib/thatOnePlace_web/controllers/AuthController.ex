defmodule ThatOnePlaceWeb.AuthController do
  use ThatOnePlaceWeb, :controller
  import Ecto.Query, only: [from: 2]
  alias ThatOnePlace.ThatOnePlaceWeb.User
  alias ThatOnePlace.Repo
  alias ThatOnePlaceWeb.UserAuth

  def index(conn, %{"uuid" => uuid}) do

    case Ecto.UUID.dump(uuid) do
      {:ok, uuid} ->
        query = from u in User,
              where: u.deviceIdentifier == ^uuid

        case Repo.one(query) do
          nil ->
            render conn, "index.json", %{message: %{success: "no", error: "invalid UUID"}}
          struct ->
            {:ok, key, _} = UserAuth.encode_and_sign(struct.deviceIdentifier)
            profile = %{UUID: struct.deviceIdentifier, lastRequest: struct.lastRequest, time: timediff(struct.lastRequest)}
            render conn, "index.json", %{message: %{success: "yes", token: key, profile: profile}}
        end
      :error ->
        render conn, "index.json", %{message: %{success: "no", error: "invalid UUID"}}
    end



  end

  def create(conn, %{"uuid" => uuid}) do
    case Repo.insert(User.changeset(%User{}, %{deviceIdentifier: uuid})) do
      {:ok, _changeset} ->
        render conn, "index.json", %{message: %{success: "yes"}}
      {:error, _error} ->
        render conn, "index.json", %{message: %{success: "no", error: "fucking have to deal with this shit too?!"}}
    end
  end

  def whoami(conn, _) do
    struct = Guardian.Plug.current_resource(conn)
    struct = %{UUID: struct.deviceIdentifier, lastRequest: struct.lastRequest}
    render(conn, "whoami.json", %{information: %{profile: struct}})
  end

  def timediff(lastRequest) do
    if lastRequest == nil do
      0
    else
      diff = abs(DateTime.diff(lastRequest, DateTime.utc_now(), :seconds))
      if diff > 14400 do
        0
      else
        14400 - diff
      end
    end
  end

end
