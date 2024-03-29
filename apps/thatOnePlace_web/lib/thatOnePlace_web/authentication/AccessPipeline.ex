defmodule ThatOnePlaceWeb.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :thatOnePlace_web

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: false
end
