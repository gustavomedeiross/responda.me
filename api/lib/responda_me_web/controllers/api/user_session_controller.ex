defmodule Responda.MeWeb.Api.UserSessionController do
  use Responda.MeWeb, :controller

  alias Responda.Me.Accounts
  alias Responda.Me.Guardian

  action_fallback Responda.MeWeb.FallbackController

  def create(conn, attrs) do
    with {:ok, user} <- Accounts.get_user_by_email_and_password(attrs) do
      {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user, %{})

      conn
      |> put_status(:created)
      |> render("create.json", %{user: user, jwt: jwt})
    end
  end
end

