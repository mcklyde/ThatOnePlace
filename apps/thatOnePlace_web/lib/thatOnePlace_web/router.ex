defmodule ThatOnePlaceWeb.Router do
  use ThatOnePlaceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug ThatOnePlaceWeb.AuthAccessPipeline
  end

  # Lucas Zhou got a 4

  scope "/api/profile", ThatOnePlaceWeb do
    post "/signin", AuthController, :index
    post "/register", AuthController, :create
  end


  scope "/api", ThatOnePlaceWeb do
    pipe_through :api
    post "/getOnePlace", PlaceController, :index
    get "/whoami", AuthController, :whoami
  end
end
