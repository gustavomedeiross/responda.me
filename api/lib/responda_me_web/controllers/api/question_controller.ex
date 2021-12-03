defmodule Responda.MeWeb.Api.QuestionController do
  use Responda.MeWeb, :controller

  alias Responda.Me.Questions
  alias Responda.Me.Questions.Question

  action_fallback Responda.MeWeb.FallbackController

  def index(conn, %{"quiz_id" => quiz_id}) do
    questions = Questions.list_questions(quiz_id)
    render(conn, "index.json", questions: questions)
  end

  def create(conn, %{"question" => question_params}) do
    with {:ok, %Question{} = question} <- Questions.create_question(question_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_question_path(conn, :show, question.quiz_id, question))
      |> render("show.json", question: question)
    end
  end

  def show(conn, %{"id" => id}) do
    question = Questions.get_question!(id)
    render(conn, "show.json", question: question)
  end

  def update(conn, %{"id" => id, "question" => question_params}) do
    question = Questions.get_question!(id)

    with {:ok, %Question{} = question} <- Questions.update_question(question, question_params) do
      render(conn, "show.json", question: question)
    end
  end

  def delete(conn, %{"id" => id}) do
    question = Questions.get_question!(id)

    with {:ok, %Question{}} <- Questions.delete_question(question) do
      send_resp(conn, :no_content, "")
    end
  end
end
