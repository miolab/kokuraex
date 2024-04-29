defmodule Kokuraex.HttpRequest.HexApi do
  @moduledoc """
  Provides functions for request to Hex API.

  - REF: https://hex.pm/policies/privacy
  """

  alias Kokuraex.Utils.Cache
  alias Kokuraex.Utils.DatetimeProcessor

  # GET and cache the package all information.
  defp _get_and_cache_package_all_information(package_name) do
    HTTPoison.get("https://hex.pm/api/packages/#{package_name}")
    |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Cache.put_cache("hex_#{package_name}_all", body, 20)
        body |> Jason.decode!()

      _ ->
        nil
    end
  end

  # GET and cache the latest release information.
  defp _get_and_cache_latest_release_information(package_name) do
    cached_value = Cache.get_cache("hex_#{package_name}_all")

    res =
      case cached_value do
        nil -> _get_and_cache_package_all_information(package_name)
        _ -> cached_value |> Jason.decode!()
      end

    cond do
      res != nil ->
        latest_version = Map.get(res, "latest_version")

        cache_key = "hex_#{package_name}_#{latest_version}"
        cached_latest_version_value = Cache.get_cache(cache_key)

        body_map =
          case cached_latest_version_value do
            nil ->
              "https://hex.pm/api/packages/#{package_name}/releases/#{latest_version}"
              |> HTTPoison.get()
              |> case do
                {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
                  Cache.put_cache(cache_key, body, 20)
                  body |> Jason.decode!()

                _ ->
                  nil
              end

            _ ->
              cached_latest_version_value |> Jason.decode!()
          end

        docs_html_url = body_map |> Map.get("docs_html_url")

        %{
          latest_version: latest_version,
          created_at:
            body_map
            |> Map.get("inserted_at")
            |> DatetimeProcessor.date_format_iso_to_ymd(),
          url: docs_html_url,
          body: "[latest version url] #{docs_html_url}"
        }

      true ->
        nil
    end
  end

  @doc """
  GET the Hex latest release information and return as Map.
  """
  @spec latest_release_information(String.t()) :: %{
          latest_version: String.t(),
          created_at: String.t(),
          url: String.t(),
          body: String.t()
        }
  def latest_release_information(package_name) do
    latest_information = _get_and_cache_latest_release_information(package_name)

    case latest_information do
      nil ->
        %{
          latest_version: "",
          created_at: "",
          url: "",
          body:
            "Our service is temporarily unavailable as we are currently refreshing our data connections. We appreciate your patience and understanding."
        }

      _ ->
        latest_information
    end
  end
end
