defmodule Kokuraex.HttpRequest.GithubApi do
  @moduledoc """
  Provides functions for request to GitHub API.
  """

  alias Kokuraex.Utils.DatetimeProcessor
  alias Kokuraex.Utils.Cache

  defp _github_api_header() do
    [
      {"Authorization", "Bearer #{System.get_env("GITHUB_API_TOKEN")}"},
      {"Accept", "application/vnd.github+json"},
      {"X-GitHub-Api-Version", "2022-11-28"}
    ]
  end

  # GET and cache the repository latest release information.
  defp _get_and_cache_latest_release_information(owner, repo) do
    HTTPoison.get(
      "https://api.github.com/repos/#{owner}/#{repo}/releases/latest",
      _github_api_header()
    )
    |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Cache.put_cache("#{owner}_#{repo}", body, 15)
        body

      _ ->
        nil
    end
  end

  @doc """
  GET the repository latest release information and return as Map.
  """
  @spec latest_release_information(String.t(), String.t()) :: %{
          tag_name: String.t(),
          created_at: String.t(),
          url: String.t(),
          body: String.t()
        }
  def latest_release_information(owner, repo) do
    cached_value = Cache.get_cache("#{owner}_#{repo}")

    github_release_information =
      case cached_value do
        nil -> _get_and_cache_latest_release_information(owner, repo)
        _ -> cached_value
      end

    cond do
      github_release_information != nil ->
        information_json = github_release_information |> Jason.decode!()

        %{
          tag_name: information_json |> Map.get("tag_name"),
          created_at:
            information_json
            |> Map.get("created_at")
            |> DatetimeProcessor.date_format_iso_to_ymd(),
          url: information_json |> Map.get("html_url"),
          body:
            information_json
            |> Map.get("body")
            |> Earmark.as_html!()
            |> Phoenix.HTML.raw()
        }

      true ->
        %{
          tag_name: "",
          created_at: "",
          url: "",
          body:
            "Our service is temporarily unavailable as we are currently refreshing our data connections. We appreciate your patience and understanding."
        }
    end
  end
end
