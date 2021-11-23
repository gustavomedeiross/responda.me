defmodule Responda.MeWeb.Api.QuestionView do
  use Responda.MeWeb, :view
  alias Responda.MeWeb.Api.QuestionView

  def render("index.json", %{questions: questions}) do
    %{data: render_many(questions, QuestionView, "question.json")}
  end

  def render("show.json", %{question: question}) do
    %{data: render_one(question, QuestionView, "question.json")}
  end

  def render("question.json", %{question: question}) do
    %{id: question.id,
      title: question.title}
  end
end
