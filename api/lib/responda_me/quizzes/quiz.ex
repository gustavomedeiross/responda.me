defmodule Responda.Me.Quizzes.Quiz do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "quizzes" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(quiz, attrs) do
    quiz
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
