defmodule FrescoWeb.Subdomain.PageController do
  use FrescoWeb, :controller

  def index(conn, _params) do
    render(conn, :index, %{subdomain: conn.private[:subdomain]})
  end
end
