defmodule Fresco.Repo.Migrations.CreateProductsTable do
  use Ecto.Migration

  # Note: In a non-toy application you will want to do things differently
  # (i.e adding constraints etc) but to keep things simple and short we will leave it to the code above.
  def change do
    create table(:products) do
      add :name, :string
      add :price, :string

      timestamps()
    end
  end
end
