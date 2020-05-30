defmodule Calculator.Parser do
  import Calculator.Helper

  def do_convert(exp, i) when i == length(exp) - 1, do: exp
  def do_convert(exp, i) do
    cur = Enum.at(exp, i)
    nex = Enum.at(exp, i + 1)

    cond do
      are_numbers?(String.last(cur), nex) ->
        new_exp = List.update_at(exp, i + 1, fn _x -> cur <> nex end) |> List.delete_at(i)
        do_convert(new_exp, i)

      true ->
        do_convert(exp, i + 1)
    end
  end

  def merge_negative_with_numbers(list, 0) do
    cur = Enum.at(list, 0)
    nex = Enum.at(list, 1)
    nexnex = Enum.at(list, 2)

    cond do
      cur == "-" && is_numeric?(nex) ->
        merge_negative_with_numbers(List.update_at(list, 0, fn _x -> cur <> nex end) |> List.delete_at(1), 1)

      cur == "(" && nex == "-" && is_numeric?(nexnex) ->
        merge_negative_with_numbers(
          List.update_at(list, 1, fn _x -> nex <> nexnex end) |> List.delete_at(2),
          1
        )

      cur != "-" ->
        merge_negative_with_numbers(list, 1)

      true ->
        raise "Please Enter Valid Expression"
    end
  end

  def merge_negative_with_numbers(list, i) when i == length(list), do: list
  def merge_negative_with_numbers(list, i) do
    pre = Enum.at(list, i - 1)
    cur = Enum.at(list, i)
    nex = Enum.at(list, i + 1)

    if cur == "-" && is_numeric?(nex) && (is_operator?(pre) || pre == "(") do
      merge_negative_with_numbers(
        List.update_at(list, i, fn _x -> cur <> nex end) |> List.delete_at(i + 1),
        i + 1
      )
    else
      merge_negative_with_numbers(list, i + 1)
    end
  end
end
