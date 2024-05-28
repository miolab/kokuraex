defmodule Kokuraex.Repo.Migrations.CreateTable do
  use Ecto.Migration

  def change do
    create table(:package_news) do
      add(:package_owner, :string)
      add(:package_name, :string)
      add(:package_release_information_platform, :string)
      timestamps()
    end
  end
end
