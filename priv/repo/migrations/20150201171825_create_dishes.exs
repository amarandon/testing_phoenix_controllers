defmodule Menu.Repo.Migrations.CreateDishes do
  use Ecto.Migration

  def up do
    """
    CREATE TABLE dishes (id SERIAL PRIMARY KEY, title TEXT,
                         description TEXT, price DECIMAL)
    """
  end

  def down do
    "DROP TABLE dishes"
  end
end
