defmodule ThatOnePlaceWeb.Router do
  use ThatOnePlaceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ThatOnePlaceWeb do
    pipe_through :api
    post "/getOnePlace", PlaceController, :index
  end
end
