defmodule Responda.Me.Questions.Question do
  use Ecto.Schema
  import Ecto.Changeset

  alias Responda.Me.Quizzes
  alias Responda.Me.Questions

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions" do
    field :title, :string
    has_many :alternatives, Questions.Alternative, on_replace: :delete
    belongs_to :quiz, Quizzes.Quiz

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:title, :quiz_id])
    |> cast_assoc(:alternatives, required: true)
    |> validate_required([:title, :quiz_id])
  end
end
