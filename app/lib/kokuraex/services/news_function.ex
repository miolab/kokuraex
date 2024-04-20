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
        Cache.put_cache("#{owner}_#{repo}", body, 20)
        body

      _ ->
        nil
    end
  end

  @doc """
  GET the GitHub repository latest release information and return as Map.
  """
  @spec get_github_latest_release_information(String.t(), String.t()) :: %{
          tag_name: String.t(),
          created_at: String.t(),
          url: String.t(),
          body: String.t()
        }
  def get_github_latest_release_information(owner, repo) do
    cached_value = Cache.get_cache("#{owner}_#{repo}")

    github_release_information =
      case cached_value do
        nil -> _get_and_cache_github_latest_release_information(owner, repo)
        _ -> cached_value
      end

    cond do
      github_release_information != nil ->
        information_json = github_release_information |> Jason.decode!()

        %{
          tag_name: information_json |> Map.get("tag_name"),
          created_at: information_json |> Map.get("created_at"),
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
