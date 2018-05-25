defmodule ThatOnePlaceWeb.PlaceController do
  use ThatOnePlaceWeb, :controller
  alias ThatOnePlace.ThatOnePlaceWeb.User
  alias ThatOnePlace.Repo
  alias ThatOnePlaceWeb.UserAuth

  def index(conn, %{"latitude" => latitude, "longitude" => longitude}) do
    user = Guardian.Plug.current_resource(conn)
    case user.lastRequest do
      nil ->
        Repo.update(Ecto.Changeset.change user, lastRequest: DateTime.utc_now())
        response = getRestaurants(latitude, longitude)
        render conn, "message.json", %{message: response.body}
      _ ->
        diff = abs(DateTime.diff(user.lastRequest, DateTime.utc_now(), :seconds))
        if diff > 14400 do
          Repo.update(Ecto.Changeset.change user, lastRequest: DateTime.utc_now())
          response = getRestaurants(latitude, longitude)
          render conn, "message.json", %{message: response.body}
        else
          error = "Wait " <> to_string(14400 - diff) <> " seconds"
          message = %{wait: (14400-diff), message: error}
          render conn, "message.json", %{message: message}
        end

    end
  end

  defp getRestaurants(latitude, longitude) do
    response = HTTPoison.get!("https://api.yelp.com/v3/businesses/search?text=del&latitude=#{latitude}&longitude=#{longitude}",
    ["Authorization": "Bearer vbE9sKBXuhf07aNjLKnMEVuEmQl3wWorOFsORfmfEno04pb4SVoeM78KIMRDd0zkiN1aDAvsYX3Dwit4hLuR9YH9vXXEYvph2vv_eovMWsEziorHQvfOz7RWfVTMWnYx"],
    []
    )
  end

end
