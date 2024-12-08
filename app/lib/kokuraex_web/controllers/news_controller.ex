defmodule KokuraexWeb.NewsController do
  use KokuraexWeb, :controller

  alias Kokuraex.Services.NewsFunction

  def home(conn, _params) do
    render(
      conn,
      :home,
      layout: false,
      github_latest_release_information_list: _github_latest_release_information_list()
    )
  end

  defp _github_latest_release_information_list() do
    [
      elixir: NewsFunction.github_latest_release_information("elixir-lang", "elixir"),
      phoenix: NewsFunction.hex_latest_release_information("phoenix"),
      phoenix_live_view: NewsFunction.hex_latest_release_information("phoenix_live_view"),
      nx: NewsFunction.hex_latest_release_information("nx"),
      axon: NewsFunction.github_latest_release_information("elixir-nx", "axon"),
      bumblebee: NewsFunction.github_latest_release_information("elixir-nx", "bumblebee"),
      scholar: NewsFunction.github_latest_release_information("elixir-nx", "scholar")
    ]
  end
end
