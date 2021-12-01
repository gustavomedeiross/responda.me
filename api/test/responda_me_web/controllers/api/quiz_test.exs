defmodule Responda.MeWeb.Api.QuizTest do
  use Responda.MeWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  setup [:create_user_and_assign_valid_jwt]

  describe "create quiz" do
    test "user can create a quiz and add two questions", %{conn: conn} do
      # Creates a quiz
      conn = post(conn, Routes.api_quiz_path(conn, :create), quiz: %{title: "Quiz #1"})
      assert %{"id" => quiz_id} = json_response(conn, 201)["data"]

      # Adds question #1
      conn = post(conn, Routes.api_question_path(conn, :create, quiz_id), question: %{
        "title" => "Question#1",
        "quiz_id" => quiz_id,
        "alternatives" => [
          %{"content" => "Alternative#1", "correct" => true},
          %{"content" => "Alternative#2", "correct" => false},
        ]
      })
      assert conn.status == 201

      conn = post(conn, Routes.api_question_path(conn, :create, quiz_id), question: %{
        "title" => "Question#2",
        "quiz_id" => quiz_id,
        "alternatives" => [
          %{"content" => "Alternative#1", "correct" => false},
          %{"content" => "Alternative#2", "correct" => true},
          %{"content" => "Alternative#2", "correct" => false},
        ]
      })
      assert conn.status == 201
    end
  end
end
