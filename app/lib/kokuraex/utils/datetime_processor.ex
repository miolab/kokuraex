defmodule Kokuraex.Utils.DatetimeProcessor do
  @moduledoc """
  Provides functions for processing datetime.
  This module mainly uses timezone JST.
  """

  @doc """
  ISO8601形式 "2021-01-01T00:00:00Z" を "2021-01-01" 日付文字列に置換する

  ## Examples

    iex> DatetimeProcessor.date_format_iso_to_ymd("2024-04-10T10:20:20Z")
    "2024-04-10"

    iex> DatetimeProcessor.date_format_iso_to_ymd("2024-04-10T10:20:20Z9999")
    "0000-00-00"
  """
  @spec date_format_iso_to_ymd(String.t()) :: String.t()
  def date_format_iso_to_ymd(iso_date_string) do
    iso_date_string
    |> DateTime.from_iso8601()
    |> case do
      {:ok, datetime, _} ->
        datetime
        |> DateTime.to_date()
        |> Date.to_string()

      {:error, _} ->
        "0000-00-00"
    end
  end
end
