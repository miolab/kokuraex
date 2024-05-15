defmodule Kokuraex.Contexts.News do
  @moduledoc """
  Provides CRUD operations for the table `package_news` entities.
  """
  import Ecto.Query, warn: false

  alias Kokuraex.Repo
  alias Kokuraex.Schema.PackageNews

  @typedoc """
  Defines type of `package_news` table columns map.
  """
  @type package_news_map :: %{
          id: non_neg_integer,
          inserted_at: String.t(),
          updated_at: String.t(),
          package_owner: String.t(),
          package_name: String.t(),
          package_release_information_platform: String.t()
        }

  @doc """
  Returns a list of `package_news` all records.

  - Result ORDER is by `updated_at` DESC.
  """
  @spec get_all_items() :: [package_news_map()] | []
  def get_all_items() do
    query =
      from(item in PackageNews,
        select: %{
          id: item.id,
          inserted_at: item.inserted_at,
          updated_at: item.updated_at,
          package_owner: item.package_owner,
          package_name: item.package_name,
          package_release_information_platform: item.package_release_information_platform
        },
        order_by: [desc: item.updated_at]
      )

    Repo.all(query)
  end

  @doc """
  Returns a `package_news` record by the package_name.
  """
  @spec get_item_by_package_name(String.t()) :: package_news_map() | nil
  def get_item_by_package_name(package_name) do
    query =
      from(item in PackageNews,
        select: %{
          id: item.id,
          inserted_at: item.inserted_at,
          updated_at: item.updated_at,
          package_owner: item.package_owner,
          package_name: item.package_name,
          package_release_information_platform: item.package_release_information_platform
        },
        where: item.package_name == ^package_name
      )

    Repo.one(query)
  end

  @doc """
  Inserts a new record to `package_news`.
  """
  @spec create_item(%{
          package_owner: String.t(),
          package_name: String.t(),
          package_release_information_platform: String.t()
        }) :: term()
  def create_item(attrs) do
    %PackageNews{}
    |> PackageNews.changeset(attrs)
    |> Repo.insert()
  end
end
