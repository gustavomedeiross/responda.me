defmodule Responda.Me.Repo.Migrations.CreateQuestionAlternatives do
  use Ecto.Migration

  def change do
    create table(:question_alternatives, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :content, :string, null: false
      add :correct, :boolean, null: false
      add :question_id, references(:questions, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create index(:question_alternatives, [:question_id])
  end
end
