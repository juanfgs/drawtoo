defmodule Drawtoo.Strokes do
  @moduledoc """
  The Strokes context.
  """

  import Ecto.Query, warn: false
  alias Drawtoo.Repo

  alias Drawtoo.Strokes.Stroke

  @doc """
  Returns the list of strokes.

  ## Examples

      iex> list_strokes()
      [%Stroke{}, ...]

  """
  def list_strokes do
    Repo.all(Stroke)
  end

  @doc """
  Gets a single stroke.

  Raises `Ecto.NoResultsError` if the Stroke does not exist.

  ## Examples

      iex> get_stroke!(123)
      %Stroke{}

      iex> get_stroke!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stroke!(id), do: Repo.get!(Stroke, id)

  @doc """
  Creates a stroke.

  ## Examples

      iex> create_stroke(%{field: value})
      {:ok, %Stroke{}}

      iex> create_stroke(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stroke(attrs \\ %{}) do
    %Stroke{}
    |> Stroke.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stroke.

  ## Examples

      iex> update_stroke(stroke, %{field: new_value})
      {:ok, %Stroke{}}

      iex> update_stroke(stroke, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stroke(%Stroke{} = stroke, attrs) do
    stroke
    |> Stroke.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a stroke.

  ## Examples

      iex> delete_stroke(stroke)
      {:ok, %Stroke{}}

      iex> delete_stroke(stroke)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stroke(%Stroke{} = stroke) do
    Repo.delete(stroke)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stroke changes.

  ## Examples

      iex> change_stroke(stroke)
      %Ecto.Changeset{data: %Stroke{}}

  """
  def change_stroke(%Stroke{} = stroke, attrs \\ %{}) do
    Stroke.changeset(stroke, attrs)
  end
end
