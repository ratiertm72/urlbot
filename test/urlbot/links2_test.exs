defmodule Urlbot.Links2Test do
  use Urlbot.DataCase

  alias Urlbot.Links2

  describe "links2" do
    alias Urlbot.Links2.Link2

    import Urlbot.Links2Fixtures

    @invalid_attrs %{url: nil, visits: nil}

    test "list_links2/0 returns all links2" do
      link2 = link2_fixture()
      assert Links2.list_links2() == [link2]
    end

    test "get_link2!/1 returns the link2 with given id" do
      link2 = link2_fixture()
      assert Links2.get_link2!(link2.id) == link2
    end

    test "create_link2/1 with valid data creates a link2" do
      valid_attrs = %{url: "some url", visits: 42}

      assert {:ok, %Link2{} = link2} = Links2.create_link2(valid_attrs)
      assert link2.url == "some url"
      assert link2.visits == 42
    end

    test "create_link2/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links2.create_link2(@invalid_attrs)
    end

    test "update_link2/2 with valid data updates the link2" do
      link2 = link2_fixture()
      update_attrs = %{url: "some updated url", visits: 43}

      assert {:ok, %Link2{} = link2} = Links2.update_link2(link2, update_attrs)
      assert link2.url == "some updated url"
      assert link2.visits == 43
    end

    test "update_link2/2 with invalid data returns error changeset" do
      link2 = link2_fixture()
      assert {:error, %Ecto.Changeset{}} = Links2.update_link2(link2, @invalid_attrs)
      assert link2 == Links2.get_link2!(link2.id)
    end

    test "delete_link2/1 deletes the link2" do
      link2 = link2_fixture()
      assert {:ok, %Link2{}} = Links2.delete_link2(link2)
      assert_raise Ecto.NoResultsError, fn -> Links2.get_link2!(link2.id) end
    end

    test "change_link2/1 returns a link2 changeset" do
      link2 = link2_fixture()
      assert %Ecto.Changeset{} = Links2.change_link2(link2)
    end
  end
end
