defmodule Urlbot.Links do
  @moduledoc """
  The Links context.
  """

  import Ecto.Query, warn: false
  alias Urlbot.Repo

  alias Urlbot.Links.Link

  @doc """
  Returns the list of links.

  ## Examples

      iex> list_links()
      [%Link{}, ...]

  """
  def list_links(account) do
    account_id = Map.fetch!(account, :id)

    # from(s in Link, where: s.account_id == ^account.id, order_by: [asc: :id])

    query = from(s in Link,
                 where: s.account_id == ^account_id,
                 order_by: [asc: s.inserted_at])
    Repo.all(query)
  end

  @doc """
  Gets a single link.

  Raises `Ecto.NoResultsError` if the Link does not exist.

  ## Examples

      iex> get_link!(123)
      %Link{}

      iex> get_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_link!(account, hash) do
    IO.inspect(account)
    IO.inspect(hash)
    IO.inspect(Repo.get_by!(Link, account_id: account.id, hash: hash))

    Repo.get_by!(Link, account_id: account.id, hash: hash)

  end
  @doc """
  Creates a link.

  ## Examples

      iex> create_link(%{field: value})
      {:ok, %Link{}}

      iex> create_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_link(account, attrs \\ %{}) do
    Ecto.build_assoc(account, :links)
    |> Link.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a link.zsd

  ## Examples

      iex> update_link(link, %{field: new_value})
      {:ok, %Link{}}

      iex> update_link(link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_link(%Link{} = link, attrs) do
    link
    |> Link.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a link.

  ## Examples

      iex> delete_link(link)
      {:ok, %Link{}}

      iex> delete_link(link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link(%Link{} = link) do
    Repo.delete(link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link changes.

  ## Examples

      iex> change_link(link)
      %Ecto.Changeset{data: %Link{}}

  """
  def change_link(%Link{} = link, attrs \\ %{}) do
    Link.changeset(link, attrs)
  end



  def get_short_url_link!(hash) do
    Repo.get!(Link, hash: hash)
  end

  def increment_visits(%Link{} = link) do
    from(s in Link, where: s.account_id == ^link.account_id, update: [inc: [visits: 1]])
    |> Repo.update_all([])
  end

end
