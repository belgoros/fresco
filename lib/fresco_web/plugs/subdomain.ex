defmodule FrescoWeb.Plugs.Subdomain do
  @behaviour Plug

  import Plug.Conn, only: [put_private: 3, halt: 1]

  # we will use the options parameter and merge the incoming options with the existing one
  def init(opts) do
    Map.merge(
      opts,
      %{root_host: FrescoWeb.Endpoint.config(:url)[:host]}
    )
  end

  # unpack subdomain_router argument
  def call(
        %Plug.Conn{host: host} = conn,
        %{root_host: root_host, subdomain_router: router}
      ) do
    case extract_subdomain(host, root_host) do
      subdomain when byte_size(subdomain) > 0 ->
        put_private(conn, :subdomain, subdomain)
        # <--- call the router with the incoming connection
        |> router.call(router.init({}))
        |> halt()

      _ ->
        conn
    end
  end

  defp extract_subdomain(host, root_host) do
    String.replace(host, ~r/.?#{root_host}/, "")
  end
end
