defmodule Responda.Me.QuizzesTest do
  use Responda.Me.DataCase
  import Responda.Me.Factory

  alias Responda.Me.Quizzes

  describe "quizzes" do
    alias Responda.Me.Quizzes.Quiz

    def quiz_fixture(attrs \\ %{}) do
      insert!(:quiz, attrs)
    end

    test "get_quiz!/1 returns the quiz with given id" do
      quiz = quiz_fixture()
      assert Quizzes.get_quiz!(quiz.id).id == quiz.id
    end

    test "create_quiz/1 with valid data creates a quiz" do
      user = insert!(:user)
      assert {:ok, %Quiz{} = quiz} = Quizzes.create_quiz(%{title: "some title", user_id: user.id})
      assert quiz.title == "some title"
      assert quiz.user_id == user.id
    end

    test "create_quiz/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quizzes.create_quiz(%{})
    end

    test "update_quiz/2 with valid data updates the quiz" do
      quiz = quiz_fixture()
      assert {:ok, %Quiz{} = quiz} = Quizzes.update_quiz(quiz, %{title: "some updated title"})
      assert quiz.title == "some updated title"
    end

    test "delete_quiz/1 deletes the quiz" do
      quiz = quiz_fixture()
      assert {:ok, %Quiz{}} = Quizzes.delete_quiz(quiz)
      assert_raise Ecto.NoResultsError, fn -> Quizzes.get_quiz!(quiz.id) end
    end
  end
end
