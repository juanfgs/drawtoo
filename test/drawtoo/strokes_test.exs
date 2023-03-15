defmodule Drawtoo.StrokesTest do
  use Drawtoo.DataCase

  alias Drawtoo.Strokes

  describe "strokes" do
    alias Drawtoo.Strokes.Stroke

    import Drawtoo.StrokesFixtures

    @invalid_attrs %{data: nil}

    test "list_strokes/0 returns all strokes" do
      stroke = stroke_fixture()
      assert Strokes.list_strokes() == [stroke]
    end

    test "get_stroke!/1 returns the stroke with given id" do
      stroke = stroke_fixture()
      assert Strokes.get_stroke!(stroke.id) == stroke
    end

    test "create_stroke/1 with valid data creates a stroke" do
      valid_attrs = %{data: %{}}

      assert {:ok, %Stroke{} = stroke} = Strokes.create_stroke(valid_attrs)
      assert stroke.data == %{}
    end

    test "create_stroke/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Strokes.create_stroke(@invalid_attrs)
    end

    test "update_stroke/2 with valid data updates the stroke" do
      stroke = stroke_fixture()
      update_attrs = %{data: %{}}

      assert {:ok, %Stroke{} = stroke} = Strokes.update_stroke(stroke, update_attrs)
      assert stroke.data == %{}
    end

    test "update_stroke/2 with invalid data returns error changeset" do
      stroke = stroke_fixture()
      assert {:error, %Ecto.Changeset{}} = Strokes.update_stroke(stroke, @invalid_attrs)
      assert stroke == Strokes.get_stroke!(stroke.id)
    end

    test "delete_stroke/1 deletes the stroke" do
      stroke = stroke_fixture()
      assert {:ok, %Stroke{}} = Strokes.delete_stroke(stroke)
      assert_raise Ecto.NoResultsError, fn -> Strokes.get_stroke!(stroke.id) end
    end

    test "change_stroke/1 returns a stroke changeset" do
      stroke = stroke_fixture()
      assert %Ecto.Changeset{} = Strokes.change_stroke(stroke)
    end
  end
end
