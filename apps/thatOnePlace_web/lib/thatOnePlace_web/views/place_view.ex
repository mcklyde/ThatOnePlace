defmodule ThatOnePlaceWeb.PlaceView do
  use ThatOnePlaceWeb, :view

  def render("message.json", %{message: message}) do
    message
  end

end
