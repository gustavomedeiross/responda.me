defmodule Responda.Me.Repo.Migrations.AddUserIdColumnToQuizzes do
  use Ecto.Migration

  def change do
    alter table(:quizzes) do
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id), null: false
    end

    create index(:quizzes, [:user_id])
  end
end
