defmodule Responda.Me.Questions.Alternative do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "question_alternatives" do
    field :content, :string
    field :correct, :boolean
    belongs_to :question, Responda.Me.Questions.Question

    timestamps()
  end

  @doc false
  def changeset(question_alternative, attrs) do
    question_alternative
    |> cast(attrs, [:content, :correct])
    |> validate_required([:content, :correct])
  end
end
