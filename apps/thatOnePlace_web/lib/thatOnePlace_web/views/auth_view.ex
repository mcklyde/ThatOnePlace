defmodule ThatOnePlaceWeb.AuthView do
  use ThatOnePlaceWeb, :view

  def render("whoami.json", %{message: information}) do
    information
  end

  def render("index.json", %{message: message}) do
    message
  end
end
