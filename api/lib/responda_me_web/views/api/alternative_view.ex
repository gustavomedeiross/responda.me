defmodule Responda.MeWeb.Api.AlternativeView do
  use Responda.MeWeb, :view

  def render("alternative.json", %{alternative: alternative}) do
    %{content: alternative.content,
      correct: alternative.correct}
  end
end
