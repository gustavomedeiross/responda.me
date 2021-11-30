defmodule Responda.Me.Quizzes.Quiz do
  use Ecto.Schema
  import Ecto.Changeset

  alias Responda.Me.Questions
  alias Responda.Me.Accounts

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "quizzes" do
    field :title, :string
    has_many :questions, Questions.Question
    belongs_to :user, Accounts.User

    timestamps()
  end

  @doc false
  def create_changeset(quiz, attrs) do
    quiz
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title, :user_id])
    |> foreign_key_constraint(:user_id)
  end

  @doc false
  def update_changeset(quiz, attrs) do
    quiz
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
