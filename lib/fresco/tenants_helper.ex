defmodule Fresco.TenantsHelper do
  alias Fresco.Accounts
  alias Fresco.Repo

  def create_tenant(name, brand_colour) do
    Triplex.create_schema(name, Repo, fn tenant, repo ->
      {:ok, _} = Triplex.migrate(tenant, repo)

      Repo.transaction(fn ->
        with {:ok, account} <-
               Accounts.create_account(%{name: tenant, brand_colour: brand_colour}) do
          {:ok, account}
        else
          {:error, error} ->
            Repo.rollback(error)
        end
      end)
    end)
  end
end
