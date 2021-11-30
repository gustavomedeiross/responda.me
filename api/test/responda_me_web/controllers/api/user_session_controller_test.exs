defmodule Responda.MeWeb.Api.UserSessionControllerTest do
  use Responda.MeWeb.ConnCase, async: true

  import Responda.Me.AccountsFixtures

  setup do
    %{user: user_fixture()}
  end

  describe "POST /api/users/sessions" do
    test "with valid password user can login", %{conn: conn, user: user} do
      conn =
        post(conn, Routes.api_user_session_path(conn, :create),
          email: user.email,
          password: valid_user_password()
        )

      assert %{
        "token" => "" <> _,
        "user" => %{
          "email" => "" <> _,
          "first_name" => "" <> _,
          "last_name" => "" <> _,
          "full_name" => "" <> _,
        },
        "message" => "You are successfully logged in" <> _
      } = json_response(conn, 201)
    end
    test "with no credentials user can't login", %{conn: conn} do
      conn = post(conn, Routes.api_user_session_path(conn, :create), email: nil, password: nil)
      assert %{"errors" => %{"email" => ["can't be blank"], "password" => ["can't be blank"]}} = json_response(conn, 422)
    end
  end
end

