defmodule Responda.MeWeb.Api.QuestionControllerTest do
  use Responda.MeWeb.ConnCase

  import Responda.Me.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  setup [:create_user_and_assign_valid_jwt]

  describe "index" do
    test "lists all questions", %{conn: conn} do
      quiz = insert!(:quiz)
      for _ <- 1..3 do
        insert!(:question, quiz_id: quiz.id, alternatives: [
          build(:alternative, correct: true),
          build(:alternative, correct: false),
        ])
      end
      conn = get(conn, Routes.api_question_path(conn, :index, quiz.id))
      assert length(json_response(conn, 200)["data"]) == 3
    end
  end
end
