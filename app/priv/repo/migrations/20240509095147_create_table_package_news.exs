defmodule Kokuraex.Repo.Migrations.CreateTablePackageNews do
  use Ecto.Migration

  def change do
    create table(:package_news) do
      add(:package_news_id, :integer, partition_key: true, auto_increment: true)
      add(:package_owner, :string)
      add(:package_name, :string)
      timestamps()
      add(:package_release_information_platform, :string)
    end
  end
end
