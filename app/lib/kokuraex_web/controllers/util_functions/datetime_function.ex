defmodule KokuraexWeb.DatetimeFunction do
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
  def return_datetime({:ok, body}) do
    datetime =
      body
      |> NaiveDateTime.to_string()

    Regex.replace(~r/:\d{2}$/, datetime, "(JST)")
  end

  def return_datetime({:error, _}), do: "0000-00-00 00:00(JST)"

  @doc """
  現在のJST時刻を取得する
  """
  def current_jst_datetime() do
    Timex.now("Japan")
    |> DateTime.to_iso8601()
  end
end
