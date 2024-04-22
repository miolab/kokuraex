defmodule Kokuraex.Services.DatetimeFunction do
  @moduledoc """
  Conveniences for handling of Date and Time.
  """

  @doc """
  日時文字列 "2021-01-01T00:00:00+09:00" 形式を {:ok, ~N[2021-01-01 00:00:00]} 形式に置換する
  """
  def datetime_from_iso8601(datetime_string) do
    datetime_string
    |> NaiveDateTime.from_iso8601()
  end

  @doc """
  JST日時 {:ok, ~N[2021-01-01 00:00:00]} 形式を、"2021-01-01 00:00(JST)" 文字列に置換する
  """
  def return_datetime({:ok, naive}) do
    datetime =
      naive
      |> NaiveDateTime.to_string()

    Regex.replace(~r/:\d{2}$/, datetime, "(JST)")
  end

  def return_datetime({:error, _}), do: "0000-00-00 00:00(JST)"

  @doc """
  ISO8601形式 "2021-01-01T00:00:00Z" を "2021-01-01" 日付文字列に置換する
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

  @doc """
  現在のJST時刻を取得してISO8601形式で返す
  """
  @spec current_jst_datetime() :: String.t()
  def current_jst_datetime() do
    Timex.now("Japan")
    |> DateTime.to_iso8601()
  end

  @doc """
  ISO8601形式を持つ特定の日時をJST現在日時と日付比較し結果を返す
  """
  def compare_date_with_current_jst_date(datetime_iso8601) do
    {:ok, naive} =
      datetime_iso8601
      |> datetime_from_iso8601()

    {:ok, current_jst_date} =
      current_jst_datetime()
      |> datetime_from_iso8601()

    Date.compare(
      naive |> NaiveDateTime.to_date(),
      current_jst_date |> NaiveDateTime.to_date()
    )
  end
end
