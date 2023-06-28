defmodule FrescoWeb.Subdomain.ProductsController do
  use FrescoWeb, :controller

  alias Fresco.Products
  alias Fresco.Accounts

  def index(conn, _params) do
    tenant = conn.private[:subdomain]
    all_products = Products.list_products(tenant)
    brand_colour = Accounts.get_account!(tenant).brand_colour

    # Note I: You’ll notice that we’re passing CSS styling to the template.
    # This is not something I would do in a real-world project but it helps keep the example simple
    render(
      conn,
      "index.html",
      %{
        subdomain: tenant,
        products: all_products,
        style: "background-color: #{brand_colour};"
      }
    )
  end
end
