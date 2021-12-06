defmodule Responda.Me.QuestionsTest do
  use Responda.Me.DataCase
  import Responda.Me.Factory

  alias Responda.Me.Questions

  def question_fixture(), do: insert!(:question, quiz: build(:quiz))

  describe "questions" do
    alias Responda.Me.Questions.Question

    # TODO: this test should only exist at the controller level
    test "can get a question detail" do
      question = question_fixture()
      assert Questions.get_question!(question.id).id == question.id
    end

    test "should create a question with valid data" do
      %{id: quiz_id} = insert! :quiz
      attrs = %{
        title: "some title",
        quiz_id: quiz_id,
        alternatives: [
          %{content: "alternative#1", correct: true},
          %{content: "alternative#2", correct: false}
        ],
      }
      assert {:ok, %Question{} = question} = Questions.create_question(attrs)
      assert %{
        title: "some title",
        quiz_id: ^quiz_id,
        alternatives: [
          %{content: "alternative#1", correct: true},
          %{content: "alternative#2", correct: false}
        ],
      } = question
    end

    test "should not create a question without alternatives" do
      %{id: quiz_id} = insert! :quiz
      attrs = %{
        title: "some title",
        quiz_id: quiz_id,
        alternatives: [],
      }
      assert {:error, %Ecto.Changeset{}} = Questions.create_question(attrs)
    end

    test "should not create a question with more than one correct alternative" do
      %{id: quiz_id} = insert! :quiz
      attrs = %{
        title: "some title",
        quiz_id: quiz_id,
        alternatives: [
          %{content: "alternative#1", correct: true},
          %{content: "alternative#2", correct: true},
          %{content: "alternative#3", correct: false}
        ],
      }
      assert {:error, %Ecto.Changeset{}} = Questions.create_question(attrs)
    end

    test "should not create question with invalid data" do
      assert {:error, %Ecto.Changeset{}} = Questions.create_question(%{})
    end

    test "updates question with valid data" do
      question = insert!(:question, quiz: build(:quiz), alternatives: [
        build(:alternative, [content: "#1", correct: true]),
        build(:alternative, [content: "#2", correct: false]),
        build(:alternative, [content: "#3", correct: false]),
      ])
      attrs = %{
        title: "an updated title",
        alternatives: [
          %{content: "1!", correct: false},
          %{content: "2!", correct: true},
          %{content: "3!", correct: false}
        ],
      }
      assert {:ok, %Question{} = question} = Questions.update_question(question, attrs)
      assert %{
        title: "an updated title",
        alternatives: [
          %{content: "1!", correct: false},
          %{content: "2!", correct: true},
          %{content: "3!", correct: false}
        ],
      } = question
    end

    test "should not update a question with more than one correct alternative" do
      question = insert!(:question, quiz: build(:quiz), alternatives: [
        build(:alternative, [content: "#1", correct: true]),
        build(:alternative, [content: "#2", correct: false]),
        build(:alternative, [content: "#3", correct: false]),
      ])
      attrs = %{
        alternatives: [
          %{content: "1!", correct: true},
          %{content: "2!", correct: true},
          %{content: "3!", correct: false}
        ],
      }
      assert {:error, %Ecto.Changeset{}} = Questions.update_question(question, attrs)
    end

    test "should not update a question without alternatives" do
      insert!(:question, quiz: build(:quiz), alternatives: [
        build(:alternative, [content: "#1", correct: true]),
        build(:alternative, [content: "#2", correct: false]),
      ])
      assert {:error, %Ecto.Changeset{}} = Questions.create_question(%{alternatives: []})
    end

    test "should not update question with invalid data" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Questions.update_question(question, %{})
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Questions.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Questions.get_question!(question.id) end
    end
  end
end
