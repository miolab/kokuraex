defmodule Kokuraex.Services.NewsFunction do
  @moduledoc """
  Provides functions for handling news about Elixir topics.
  """

  alias Kokuraex.HttpRequest.GithubApi
  alias Kokuraex.HttpRequest.HexApi

  @doc """
  GET the GitHub repository latest release information and return as Map.
  """
  @spec github_latest_release_information(String.t(), String.t()) :: %{
          latest_version: String.t(),
          created_at: String.t(),
          url: String.t(),
          body: String.t()
        }
  def github_latest_release_information(owner, repo),
    do: GithubApi.latest_release_information(owner, repo)

  @doc """
  GET the Hex latest release information and return as Map.
  """
  @spec hex_latest_release_information(String.t()) :: %{
          latest_version: String.t(),
          created_at: String.t(),
          url: String.t(),
          body: String.t()
        }
  def hex_latest_release_information(package_name),
    do: HexApi.latest_release_information(package_name)
end
