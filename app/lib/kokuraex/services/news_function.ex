defmodule Kokuraex.Services.NewsFunction do
  @moduledoc """
  Provides functions for handling news about Elixir topics.
  """

  alias Kokuraex.HttpRequest.GithubApi

  @doc """
  GET the GitHub repository latest release information and return as Map.
  """
  @spec github_latest_release_information(String.t(), String.t()) :: %{
          tag_name: String.t(),
          created_at: String.t(),
          url: String.t(),
          body: String.t()
        }
  def github_latest_release_information(owner, repo) do
    GithubApi.latest_release_information(owner, repo)
  end
end
