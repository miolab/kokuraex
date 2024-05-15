defmodule Kokuraex.Repo.Migrations.AlterTablePackageNewsDropPackageNewsId do
  use Ecto.Migration

  def change do
    alter table(:package_news) do
      remove(:package_news_id)
    end
  end
end
