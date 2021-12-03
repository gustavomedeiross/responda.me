defmodule Responda.MeWeb.Api.QuestionView do
  use Responda.MeWeb, :view
  alias Responda.MeWeb.Api.QuestionView
  alias Responda.MeWeb.Api.AlternativeView

  def render("index.json", %{questions: questions}) do
    %{data: render_many(questions, QuestionView, "question.json")}
  end

  def render("show.json", %{question: question}) do
    %{data: %{
      id: question.id,
      title: question.title,
      quiz_id: question.quiz_id,
      alternatives: render_many(question.alternatives, AlternativeView, "alternative.json")
    }}
  end

  def render("question.json", %{question: question}) do
    %{id: question.id,
      title: question.title}
  end
end
