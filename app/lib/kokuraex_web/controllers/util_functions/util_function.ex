defmodule KokuraexWeb.UtilFunction do
  @moduledoc """
  Utility functions.
  """

  @doc """
  :eqか:gtならtrue、:ltならfalseを返す
  """
  def is_eq_or_gt_atom(:eq), do: true
  def is_eq_or_gt_atom(:gt), do: true
  def is_eq_or_gt_atom(:lt), do: false
end
