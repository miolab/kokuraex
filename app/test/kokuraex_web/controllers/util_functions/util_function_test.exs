defmodule KokuraexWeb.UtilFunctionTest do
  use KokuraexWeb.ConnCase
  import KokuraexWeb.UtilFunction

  test "test_`:eq`か`:gt`ならtrue、`:lt`ならfalseを返す" do
    assert is_eq_or_gt_atom(:eq) === true
    assert is_eq_or_gt_atom(:gt) === true
    assert is_eq_or_gt_atom(:lt) === false
  end
end
