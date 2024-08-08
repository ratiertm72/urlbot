defmodule Urlbot.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Urlbot.Users.User
  alias Urlbot.Links.Link

  schema "accounts" do
    field :name, :string

    has_many :users, User # Add this line
    has_many :links, Link # Add this line

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
