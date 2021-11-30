defmodule Responda.MeWeb.Api.RegisterUserController do
  use Responda.MeWeb, :controller

  alias Responda.Me.Accounts

  action_fallback Responda.MeWeb.FallbackController

  def create(conn, attrs) do
    with {:ok, _user} <- Accounts.register_user(attrs) do
      send_resp(conn, 201, "")
    end
  end
end

