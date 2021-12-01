defmodule Responda.MeWeb.Api.QuizControllerTest do
  use Responda.MeWeb.ConnCase
  import Responda.Me.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  setup [:create_user_and_assign_valid_jwt]

  describe "index" do
    test "lists all quizzes", %{conn: conn, user: user} do
      quiz = insert!(:quiz, user: user)

      conn = get(conn, Routes.api_quiz_path(conn, :index))
      assert json_response(conn, 200)["data"] == [
        %{"id" => quiz.id, "title" => quiz.title}
      ]
    end
  end

  describe "show" do
    test "show one quiz", %{conn: conn, user: user} do
      quiz = insert!(:quiz, user: user)

      conn = get(conn, Routes.api_quiz_path(conn, :show, quiz.id))
      assert json_response(conn, 200) == %{
        "data" => %{
          "id" => quiz.id,
          "title" => quiz.title,
        }
      }
    end
  end
end
