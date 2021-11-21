defmodule KokuraexWeb.EventFunction do
  @moduledoc """
  Conveniences for handling of community's event informations.
  """

  import KokuraexWeb.DatetimeFunction

  @doc """
  GET event data from connmass API.
  """
  def get_connpass_events(keyword, nickname, count) do
    "https://connpass.com/api/v1/event/?keyword=#{keyword}&nickname=#{nickname}&order=2&count=#{count}"
    |> HTTPoison.get()
  end

  @doc """
  Handle result of HTTPoison response.
  """
  def handle_httpoison_result({:ok, %HTTPoison.Response{status_code: 200, body: body}}), do: body

  def handle_httpoison_result({:ok, %HTTPoison.Response{status_code: 404}}),
    do: :httpoison_notfound

  def handle_httpoison_result({:error, %HTTPoison.Error{reason: _}}), do: :httpoison_error

  def handle_httpoison_result(res), do: :httpoison_unknown

  @doc """
  Return array include connpass events Map.
  """
  def connpass_events(keyword, nickname, count) do
    res =
      get_connpass_events(keyword, nickname, count)
      |> handle_httpoison_result()

    case res do
      :httpoison_notfound ->
        [
          default_events_map()
        ]

      :httpoison_error ->
        [
          %{default_events_map() | title: "Fetch Error"}
        ]

      :httpoison_unknown ->
        [
          %{default_events_map() | title: "Unknown Error"}
        ]

      _ ->
        res_decoded_events =
          res
          |> Jason.decode!()
          |> Map.get("events")

        cond do
          res_decoded_events |> Enum.empty?() ->
            [
              %{default_events_map() | title: "No events found"}
            ]

          true ->
            res_decoded_events
            |> Enum.map(
              &%{
                default_events_map()
                | title: &1["title"],
                  started_at: &1["started_at"] |> datetime_from_iso8601() |> return_datetime(),
                  ended_at: &1["ended_at"] |> datetime_from_iso8601() |> return_datetime(),
                  is_coming_date:
                    &1["ended_at"] |> compare_date_with_current_jst_date() |> is_eq_or_gt_atom(),
                  catch: &1["catch"],
                  address: &1["address"],
                  event_url: &1["event_url"]
              }
            )
        end
    end
  end

  @doc """
  Return array include kokura.ex's connpass events Map.
  """
  def kokuraex_connpass_events() do
    connpass_events(
      "kokura_ex",
      "imlab",
      "5"
    )
  end

  @doc """
  Return array include Pelemay Meetup's connpass events Map.
  """
  def pelemay_connpass_events() do
    [
      pelemay_simd_meetup(),
      pelemay_beam_otp_meetup(),
      pelemay_history_meetup()
    ]
    |> Enum.concat()
    |> Enum.sort_by(& &1.started_at, :desc)
    |> Enum.take(5)
  end

  @doc """
  Return array include connpass events of "Pelemay Meetup SIMD勉強会" Map.
  """
  def pelemay_simd_meetup() do
    connpass_events(
      "Pelemay Meetup SIMD勉強会",
      "zacky1972",
      "3"
    )
  end

  @doc """
  Return array include connpass events of "「BEAM/OTP対話」" Map.
  """
  def pelemay_beam_otp_meetup() do
    connpass_events(
      "「BEAM/OTP対話」",
      "zacky1972",
      "3"
    )
  end

  @doc """
  Return array include connpass events of "Pelemayの歴史を振り返る会" Map.
  """
  def pelemay_history_meetup() do
    connpass_events(
      "Pelemayの歴史を振り返る会",
      "zacky1972",
      "2"
    )
  end

  @doc """
  Return default events Map format.
  """
  def default_events_map() do
    %{
      title: "Not Found",
      started_at: "-",
      ended_at: "-",
      is_coming_date: false,
      catch: "-",
      address: "-",
      event_url: "https://kokura-ex.herokuapp.com/"
    }
  end
end
