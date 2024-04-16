defmodule Kokuraex.Services.NewsFunction do
  @moduledoc """
  Provides functions for handling news about Elixir topics.
  """

  alias Kokuraex.Utils.Cache

  # GET the GitHub repository latest release information.
  defp _get_and_cache_github_latest_release_information(owner, repo) do
    res =
      "https://api.github.com/repos/#{owner}/#{repo}/releases/latest"
      |> HTTPoison.get()

    case res do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Cache.put_cache("#{owner}_#{repo}", body, 1)
        body

      _ ->
        nil
    end
  end
end
