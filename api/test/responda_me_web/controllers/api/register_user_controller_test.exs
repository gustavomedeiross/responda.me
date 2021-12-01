defmodule Responda.MeWeb.Api.RegisterUserControllerTest do
  use Responda.MeWeb.ConnCase, async: true

  import Responda.Me.AccountsFixtures

  describe "POST /api/users/sessions" do
    test "can register a user", %{conn: conn} do
      conn = post(conn, Routes.api_register_user_path(conn, :create),
        first_name: valid_first_name(),
        last_name: valid_last_name(),
        email: unique_user_email(),
        password: valid_user_password()
      )
      assert conn.status == 201
    end
  end
end

