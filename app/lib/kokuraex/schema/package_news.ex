defmodule Kokuraex.Schema.PackageNews do
  @moduledoc """
  Defines changesets for the PackageNews schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "package_news" do
    field(:package_owner, :string)
    field(:package_name, :string)
    field(:package_release_information_platform, :string)
    timestamps()
  end

  @doc """
  Generates a changeset based on the `attrs` provided.
  """
  def changeset(schema_model_instance, attrs) do
    schema_model_instance
    |> cast(attrs, [
      :package_owner,
      :package_name,
      :package_release_information_platform
    ])
    |> validate_required([:package_owner, :package_release_information_platform])
  end
end
