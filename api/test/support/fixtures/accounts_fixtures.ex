defmodule Responda.Me.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Responda.Me.Accounts` context.
  """

  def valid_first_name, do: "Gustavo"
  def valid_last_name, do: "Medeiros"
  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        first_name: valid_first_name(),
        last_name: valid_last_name(),
        email: unique_user_email(),
        password: valid_user_password()
      })
      |> Responda.Me.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token, _] = String.split(captured.body, "[TOKEN]")
    token
  end
end

