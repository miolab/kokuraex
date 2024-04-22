defmodule Kokuraex.Utils.DatetimeProcessor.DateFormatIsoToYmdTest do
  use ExUnit.Case
  alias Kokuraex.Utils.DatetimeProcessor

  doctest Kokuraex.Utils.DatetimeProcessor

  test "ISO8601形式をyyyy-mm-dd形式に変換できる" do
    assert DatetimeProcessor.date_format_iso_to_ymd("2024-04-10T10:20:20Z") == "2024-04-10"
  end

  test "不正な書式の場合は0000-00-00を返す" do
    assert DatetimeProcessor.date_format_iso_to_ymd("2024-04-10T10:20:20Z9999") == "0000-00-00"
  end
end
