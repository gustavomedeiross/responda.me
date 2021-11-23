defmodule Responda.Me.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string, null: false
      add :quiz_id, references(:quizzes, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create index(:questions, [:quiz_id])
  end
end
