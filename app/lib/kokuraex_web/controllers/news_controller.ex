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
      elixir: NewsFunction.get_github_latest_release_information("elixir-lang", "elixir"),
      bumblebee: NewsFunction.get_github_latest_release_information("elixir-nx", "bumblebee")
    ]
  end
end
