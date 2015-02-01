defmodule Menu.Dishes do
  use Ecto.Model

  schema "dishes" do
    field :title, :string
    field :description, :string
    field :price, :decimal
  end
end
