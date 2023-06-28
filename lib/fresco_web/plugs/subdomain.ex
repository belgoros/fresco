defmodule FrescoWeb.Plugs.Subdomain do
  @behaviour Plug

  import Plug.Conn, only: [put_private: 3]

  def init(_opts) do
    %{root_host: FrescoWeb.Endpoint.config(:url)[:host]}
  end

  def call(%Plug.Conn{host: host} = conn, %{root_host: root_host} = _opts) do
    case extract_subdomain(host, root_host) do
      subdomain when byte_size(subdomain) > 0 ->
        put_private(conn, :subdomain, subdomain)

      _ ->
        conn
    end
  end

  defp extract_subdomain(host, root_host) do
    String.replace(host, ~r/.?#{root_host}/, "")
  end
end
