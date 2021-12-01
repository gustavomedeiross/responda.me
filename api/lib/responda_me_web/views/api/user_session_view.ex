defmodule Responda.MeWeb.Api.UserSessionView do
  use Responda.MeWeb, :view

  def render("create.json", %{user: user, jwt: jwt}) do
    %{
      token: jwt,
      user: %{
        first_name: user.first_name,
        last_name: user.last_name,
        full_name: "#{user.first_name} #{user.last_name}",
        email: user.email,
      },
      message: "You are successfully logged in! Add this token to authorization header to make authorized requests."
    }
  end
end
