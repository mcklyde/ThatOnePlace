defmodule ThatOnePlaceWeb.PlaceController do
  use ThatOnePlaceWeb, :controller

  def index(conn, %{"latitude" => latitude, "longitude" => longitude}) do

    response = HTTPoison.get!("https://api.yelp.com/v3/businesses/search?text=del&latitude=#{latitude}&longitude=#{longitude}",
    ["Authorization": "Bearer vbE9sKBXuhf07aNjLKnMEVuEmQl3wWorOFsORfmfEno04pb4SVoeM78KIMRDd0zkiN1aDAvsYX3Dwit4hLuR9YH9vXXEYvph2vv_eovMWsEziorHQvfOz7RWfVTMWnYx"],
    []
    )

    conn
    |> put_resp_content_type("application/json")
    |> Plug.Conn.send_resp(200,response.body)



  end

end
