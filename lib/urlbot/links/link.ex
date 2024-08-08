defmodule Urlbot.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset
  alias Urlbot.Ecto.HashId # Add this line

  @primary_key {:hash, HashId, [autogenerate: true]} # Add this line
  @derive {Phoenix.Param, key: :hash} # Add this line


  schema "links" do
    field :url, :string
    field :visits, :integer
    field :account_id, :id

    timestamps(type: :utc_datetime)
  end

  @spec changeset(
          {map(), map()}
          | %{
              :__struct__ => atom() | %{:__changeset__ => any(), optional(any()) => any()},
              optional(atom()) => any()
            },
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :visits, :account_id])
    |> validate_required([:url, :visits, :account_id])
  end

end
