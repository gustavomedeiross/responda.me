defmodule Responda.Me.Factory do
  @moduledoc """
  This module defines test helpers for creating
  entities 
  """

  alias Responda.Me.Repo
  alias Responda.Me.Quizzes
  alias Responda.Me.Questions

  defp random_string(), do: "#{System.unique_integer()}"
  defp random_integer(), do: 100
  defp random_date(), do: ~N[2010-04-17 14:00:00]

  def build(:quiz) do
    %Quizzes.Quiz{
      title: random_string(),
    }
  end

  def build(:question) do
    %Questions.Question{
      title: random_string(),
    }
  end

  def build(:alternative) do
    %Questions.Alternative{
      content: random_string(),
      correct: false,
    }
  end

  def build(factory_name, attrs) do
    factory_name |> build() |> struct!(attrs)
  end

  def insert!(factory_name, attrs \\ []) do
    factory_name |> build(attrs) |> Repo.insert!()
  end
end

