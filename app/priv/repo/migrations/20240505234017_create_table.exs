defmodule Kokuraex.Repo.Migrations.CreateTable do
  use Ecto.Migration

  def change do
    create table(:package_news) do
      add(:package_news_id, :integer)
      add(:package_owner, :string)
      add(:package_name, :string)
    end
  end
end
