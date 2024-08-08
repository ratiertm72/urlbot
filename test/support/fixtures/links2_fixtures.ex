defmodule Urlbot.Links2Fixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Urlbot.Links2` context.
  """

  @doc """
  Generate a link2.
  """
  def link2_fixture(attrs \\ %{}) do
    {:ok, link2} =
      attrs
      |> Enum.into(%{
        url: "some url",
        visits: 42
      })
      |> Urlbot.Links2.create_link2()

    link2
  end
end
