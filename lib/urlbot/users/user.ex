defmodule Urlbot.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  # Add this line since we'll be using Ecto's changeset in this schema
  import Ecto.Changeset

  # Add this line to reference Account since it's used in the private function
  alias Urlbot.Accounts

  schema "users" do
    pow_user_fields()

    # Add this line
    field :account_name, :string, virtual: true

    belongs_to :account, Urlbot.Accounts.Account # Add this line

    timestamps()
  end

  # Also add this block of code to add a changeset
  def changeset(user, attrs) do
    user
    |> pow_changeset(attrs)
    |> cast(attrs, [:account_name])
    |> validate_required([:account_name])
    |> create_user_account(user)
    |> assoc_constraint(:account)
  end

  # Add the custom private function
  defp create_user_account(%{valid?: true,  changes: %{account_name: account_name}} = changeset, %{account_id: nil} = _user) do
    with {:ok, account} <- Accounts.create_account(%{name: account_name}) do
      put_assoc(changeset, :account, account)
    else
      _ -> changeset
    end
  end

  defp create_user_account(changeset, _), do: changeset

end
