defmodule Responda.Me.Questions do
  @moduledoc """
  The Questions context.
  """

  import Ecto.Query, warn: false
  alias Responda.Me.Repo

  alias Responda.Me.Questions.Question

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  def list_questions(quiz_id) do
    (from q in Question, where: q.quiz_id == ^quiz_id)
    |> Repo.all()
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question!(id) do
    Repo.get!(Question, id)
    |> Repo.preload(:alternatives)
  end

  # TODO: refactor
  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question(attrs \\ %{}) do
    import Ecto.Changeset

    question = Question.changeset(%Question{}, attrs)
    if question.valid? do
      alternatives = get_field question, :alternatives
      correct_alternatives = Enum.count alternatives, (fn a -> a.correct end)
      if correct_alternatives == 1 do
        Repo.insert(question)
      else
        {:error, :only_one_alternative_can_be_correct}
      end
    else
      {:error, question}
    end
  end

  # TODO: refactor
  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question(%Question{} = question, attrs) do
    import Ecto.Changeset

    question = Question.changeset(question, attrs)
    if question.valid? do
      alternatives = get_field question, :alternatives
      correct_alternatives = Enum.count alternatives, (fn a -> a.correct end)
      if correct_alternatives == 1 do
        Repo.update(question)
      else
        {:error, :only_one_alternative_can_be_correct}
      end
    else
      {:error, question}
    end
  end

  @doc """
  Deletes a question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question(%Question{} = question) do
    Repo.delete(question)
  end
end
