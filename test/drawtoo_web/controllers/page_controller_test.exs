defmodule DrawtooWeb.PageControllerTest do
  use DrawtooWeb.ConnCase

  describe "homepage " do
    test "should show the create game form ", %{conn: conn} do
      response = get(conn, Routes.page_path(conn, :index))
      assert html_response(response, 200) =~ "Enter your name"
    end
  end
end
