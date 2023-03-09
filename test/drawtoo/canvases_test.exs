defmodule Drawtoo.CanvassesTest do
  use Drawtoo.DataCase

  alias Drawtoo.Canvasses

  describe "canvases" do
    alias Drawtoo.Canvasses.Canvas

    import Drawtoo.CanvassesFixtures

    @invalid_attrs %{strokes: nil}

    test "list_canvases/0 returns all canvases" do
      canvas = canvas_fixture()
      assert Canvasses.list_canvases() == [canvas]
    end

    test "get_canvas!/1 returns the canvas with given id" do
      canvas = canvas_fixture()
      assert Canvasses.get_canvas!(canvas.id) == canvas
    end

    test "create_canvas/1 with valid data creates a canvas" do
      valid_attrs = %{strokes: []}

      assert {:ok, %Canvas{} = canvas} = Canvasses.create_canvas(valid_attrs)
      assert canvas.strokes == []
    end

    test "create_canvas/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Canvasses.create_canvas(@invalid_attrs)
    end

    test "update_canvas/2 with valid data updates the canvas" do
      canvas = canvas_fixture()
      update_attrs = %{strokes: []}

      assert {:ok, %Canvas{} = canvas} = Canvasses.update_canvas(canvas, update_attrs)
      assert canvas.strokes == []
    end

    test "update_canvas/2 with invalid data returns error changeset" do
      canvas = canvas_fixture()
      assert {:error, %Ecto.Changeset{}} = Canvasses.update_canvas(canvas, @invalid_attrs)
      assert canvas == Canvasses.get_canvas!(canvas.id)
    end

    test "delete_canvas/1 deletes the canvas" do
      canvas = canvas_fixture()
      assert {:ok, %Canvas{}} = Canvasses.delete_canvas(canvas)
      assert_raise Ecto.NoResultsError, fn -> Canvasses.get_canvas!(canvas.id) end
    end

    test "change_canvas/1 returns a canvas changeset" do
      canvas = canvas_fixture()
      assert %Ecto.Changeset{} = Canvasses.change_canvas(canvas)
    end
  end
end
