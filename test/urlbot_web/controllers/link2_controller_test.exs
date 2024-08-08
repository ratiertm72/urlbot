defmodule UrlbotWeb.Link2ControllerTest do
  use UrlbotWeb.ConnCase

  import Urlbot.Links2Fixtures

  @create_attrs %{url: "some url", visits: 42}
  @update_attrs %{url: "some updated url", visits: 43}
  @invalid_attrs %{url: nil, visits: nil}

  describe "index" do
    test "lists all links2", %{conn: conn} do
      conn = get(conn, ~p"/links2")
      assert html_response(conn, 200) =~ "Listing Links2"
    end
  end

  describe "new link2" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/links2/new")
      assert html_response(conn, 200) =~ "New Link2"
    end
  end

  describe "create link2" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/links2", link2: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/links2/#{id}"

      conn = get(conn, ~p"/links2/#{id}")
      assert html_response(conn, 200) =~ "Link2 #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/links2", link2: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Link2"
    end
  end

  describe "edit link2" do
    setup [:create_link2]

    test "renders form for editing chosen link2", %{conn: conn, link2: link2} do
      conn = get(conn, ~p"/links2/#{link2}/edit")
      assert html_response(conn, 200) =~ "Edit Link2"
    end
  end

  describe "update link2" do
    setup [:create_link2]

    test "redirects when data is valid", %{conn: conn, link2: link2} do
      conn = put(conn, ~p"/links2/#{link2}", link2: @update_attrs)
      assert redirected_to(conn) == ~p"/links2/#{link2}"

      conn = get(conn, ~p"/links2/#{link2}")
      assert html_response(conn, 200) =~ "some updated url"
    end

    test "renders errors when data is invalid", %{conn: conn, link2: link2} do
      conn = put(conn, ~p"/links2/#{link2}", link2: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Link2"
    end
  end

  describe "delete link2" do
    setup [:create_link2]

    test "deletes chosen link2", %{conn: conn, link2: link2} do
      conn = delete(conn, ~p"/links2/#{link2}")
      assert redirected_to(conn) == ~p"/links2"

      assert_error_sent 404, fn ->
        get(conn, ~p"/links2/#{link2}")
      end
    end
  end

  defp create_link2(_) do
    link2 = link2_fixture()
    %{link2: link2}
  end
end
