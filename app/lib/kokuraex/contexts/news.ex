defmodule Kokuraex.Contexts.News do
  @moduledoc """
  Provides CRUD operations for the table `package_news` entities.
  """
  import Ecto.Query, warn: false

  alias Kokuraex.Repo
  alias Kokuraex.Schema.PackageNews

  @doc """
  Returns a list of `package_news` all records.
  """
  @spec get_all_items() ::
          [
            %{
              id: non_neg_integer,
              inserted_at: String.t(),
              updated_at: String.t(),
              package_owner: String.t(),
              package_name: String.t(),
              package_release_information_platfor: String.t()
            }
          ]
          | []
  def get_all_items() do
    query =
      from(item in PackageNews,
        select: %{
          id: item.id,
          inserted_at: item.inserted_at,
          updated_at: item.updated_at,
          package_owner: item.package_owner,
          package_name: item.package_name,
          package_release_information_platfor: item.package_release_information_platform
        },
        order_by: [desc: item.updated_at]
      )

    Repo.all(query)
  end

  @doc """
  Returns a `package_news` record by the package_name.
  """
  @spec get_item_by_package_name(String.t()) :: map() | nil
  def get_item_by_package_name(package_name) do
    result = Repo.get_by(PackageNews, package_name: package_name)

    case result do
      nil -> nil
      _ -> result |> Map.from_struct()
    end
  end

  @doc """
  Inserts a new record to `package_news`.
  """
  @spec create_item(%{
          package_owner: String.t(),
          package_name: String.t(),
          package_release_information_platform: String.t()
        }) :: {:ok, PackageNews.t()} | {:error, Ecto.Changeset.t()}
  def create_item(attrs \\ %{}) do
    %PackageNews{}
    |> PackageNews.changeset(attrs)
    |> Repo.insert()
  end
end
