defmodule Responda.MeWeb.Api.QuizView do
  use Responda.MeWeb, :view
  alias Responda.MeWeb.Api.QuizView

  def render("index.json", %{quizzes: quizzes}) do
    %{data: render_many(quizzes, QuizView, "quiz.json")}
  end

  def render("show.json", %{quiz: quiz}) do
    %{data: render_one(quiz, QuizView, "quiz.json")}
  end

  def render("quiz.json", %{quiz: quiz}) do
    %{id: quiz.id,
      title: quiz.title}
  end
end
