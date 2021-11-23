defmodule Responda.Me.Repo.Migrations.CreateQuizzes do
  use Ecto.Migration

  def change do
    create table(:quizzes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string, null: false

      timestamps()
    end
  end
end
