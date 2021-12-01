defmodule Responda.MeWeb.Api.QuizController do
  use Responda.MeWeb, :controller

  alias Responda.Me.Guardian
  alias Responda.Me.Quizzes
  alias Responda.Me.Quizzes.Quiz

  action_fallback Responda.MeWeb.FallbackController

  def index(conn, _params) do
    quizzes = 
      conn
      |> get_user()
      |> Quizzes.list_quizzes()
    render(conn, "index.json", quizzes: quizzes)
  end

  defp get_user(conn), do: Guardian.Plug.current_resource(conn)

  def create(conn, %{"quiz" => quiz_params}) do
    user = get_user(conn)
    params = Map.put(quiz_params, "user_id", user.id)
    with {:ok, %Quiz{} = quiz} <- Quizzes.create_quiz(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_quiz_path(conn, :show, quiz))
      |> render("show.json", quiz: quiz)
    end
  end

  def show(conn, %{"id" => id}) do
    quiz = Quizzes.get_quiz!(id)
    render(conn, "show.json", quiz: quiz)
  end

  def update(conn, %{"id" => id, "quiz" => quiz_params}) do
    quiz = Quizzes.get_quiz!(id)

    with {:ok, %Quiz{} = quiz} <- Quizzes.update_quiz(quiz, quiz_params) do
      render(conn, "show.json", quiz: quiz)
    end
  end

  def delete(conn, %{"id" => id}) do
    quiz = Quizzes.get_quiz!(id)

    with {:ok, %Quiz{}} <- Quizzes.delete_quiz(quiz) do
      send_resp(conn, :no_content, "")
    end
  end
end
