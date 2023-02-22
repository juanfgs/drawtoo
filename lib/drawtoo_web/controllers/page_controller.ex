defmodule DrawtooWeb.PageController do
  use DrawtooWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
