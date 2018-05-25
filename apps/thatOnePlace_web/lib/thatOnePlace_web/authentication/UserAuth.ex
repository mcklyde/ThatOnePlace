defmodule ThatOnePlaceWeb.UserAuth do
  use Guardian, otp_app: :thatOnePlace_web
  import Ecto.Query, only: [from: 2]
  alias ThatOnePlace.ThatOnePlaceWeb.User
  alias ThatOnePlace.Repo
  alias ThatOnePlaceWeb.UserAuth

  def subject_for_token(resource, _claims) do
    # You can use any value for the subject of your token but
    # it should be useful in retrieving the resource later, see
    # how it being used on `resource_from_claims/1` function.
    # A unique `id` is a good subject, a non-unique email address
    # is a poor subject.
    sub = to_string(resource)
    {:ok, sub}
  end
  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    # Here we'll look up our resource from the claims, the subject can be
    # found in the `"sub"` key. In `above subject_for_token/2` we returned
    # the resource id so here we'll rely on that to look it up.
    uuid = claims["sub"]
        {:ok, uuid} = Ecto.UUID.dump(uuid)
        query = from u in User,
              where: u.deviceIdentifier == ^uuid
              
        case Repo.one(query) do
          nil ->
            {:error, "Invalid UUID"}
          struct ->
            {:ok, struct}
        end
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
