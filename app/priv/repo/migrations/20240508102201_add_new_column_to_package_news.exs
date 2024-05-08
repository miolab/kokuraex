defmodule Kokuraex.Repo.Migrations.AddNewColumnToPackageNews do
  use Ecto.Migration

  def change do
    alter table(:package_news) do
      add(:package_release_information_platform, :string)
    end
  end
end
