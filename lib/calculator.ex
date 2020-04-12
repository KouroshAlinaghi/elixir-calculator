defmodule Calculator do
  @moduledoc """
  Documentation for `Calculator`.
  """

  @doc """

  ## Examples

  """

  def mir_sli(list, at, l \\ 0, r \\ 0) do
#    IO.inspect "list: #{list}"
#    IO.inspect "at: #{at}"
#    IO.inspect "left: #{l}"
#    IO.inspect "right: #{r}"
    if l == r && r != 0 do
      at
    else
      case Enum.at(list, at) do
        "(" -> mir_sli(list, at + 1, l + 1, r)
        ")" -> mir_sli(list, at + 1, l, r + 1)
        _ -> mir_sli(list, at + 1, l, r)
      end
    end
  end

  def remove_pr(list, i) do
    mir = mir_sli(list, i)
    new_list = List.delete_at(list, i) |> List.delete_at(mir - 2)
  end

  def to_expression(list) do
    do_expression(list)
  end

  def do_expression(list) when length(list) == 1, do: list

  def do_expression(list) do
    IO.puts("++++++++++")
    IO.inspect(list)
    IO.puts("++++++++++")

    cond do
      Enum.find_index(list, fn x -> x == "(" end) != nil ->
        i = Enum.find_index(list, fn x -> x == "(" end) 
        l = mir_sli(list, 0)
        new_exp = Enum.slice(list, i, l) |> remove_pr(0) 
        res = do_expression(new_exp) 
        pre = Enum.take(list, i) 
        next = Enum.take(list, l-length(list)) 
        do_expression(pre++res++next)

      Enum.find_index(list, fn x -> x == "^" end) != nil ->
        i = Enum.find_index(list, fn x -> x == "^" end)
        oper = Enum.at(list, i)
        left = Enum.at(list, i - 1)
        right = Enum.at(list, i + 1)

        do_expression(
          List.delete_at(list, i - 1)
          |> List.delete_at(i - 1)
          |> List.replace_at(i - 1, calc(left, oper, right))
        )

      Enum.find_index(list, fn x -> is_special_operator?(x) end) != nil ->
        i = Enum.find_index(list, fn x -> is_special_operator?(x) end)
        oper = Enum.at(list, i)
        left = Enum.at(list, i - 1)
        right = Enum.at(list, i + 1)

        do_expression(
          List.delete_at(list, i - 1)
          |> List.delete_at(i - 1)
          |> List.replace_at(i - 1, calc(left, oper, right))
        )

      true ->
        left = Enum.at(list, 0)
        oper = Enum.at(list, 1)
        right = Enum.at(list, 2)

        do_expression(
          List.delete_at(list, 0)
          |> List.delete_at(0)
          |> List.replace_at(0, calc(left, oper, right))
        )
    end
  end

  defp to_number(str) do
    if is_float(str) do
      str
    else
      case Float.parse(str) do
        {num, ""} -> num
        # undefined number
        _ -> false
      end
    end
  end

  defp calc(l, o, r) do
    case o do
      "+" -> to_number(l) + to_number(r)
      "-" -> to_number(l) - to_number(r)
      "*" -> to_number(l) * to_number(r)
      "/" -> to_number(l) / to_number(r)
      "^" -> :math.pow(to_number(l), to_number(r))
      _ -> nil
    end
  end

  def convert(expression) do
    no_white_spaces = expression |> String.replace(" ", "")
    do_convert(String.split(no_white_spaces, "", trim: true), 0, String.length(no_white_spaces))
  end

  defp do_convert(exp, i, exp_length) when i == exp_length - 1 do
    to_expression(exp)
  end

  defp do_convert(exp, i, _exp_length) do
    cur = Enum.at(exp, i)
    nex = Enum.at(exp, i + 1)

    cond do
      are_numbers?(cur, nex) ->
        new_exp = List.update_at(exp, i + 1, fn _x -> cur <> nex end) |> List.delete_at(i)
        do_convert(new_exp, i, length(new_exp))

      true ->
        do_convert(exp, i + 1, length(exp))
    end
  end

  defp is_special_operator?(operator), do: Enum.member?(["*", "/", "(", ")"], operator)

  defp is_numeric?(str) do
    if str == "." do
      true
    else
      case Integer.parse(str) do
        {_num, ""} -> true
        _ -> false
      end
    end
  end

  defp are_numbers?(a, b) do
    if is_numeric?(a) && is_numeric?(b) do
      true
    else
      false
    end
  end
end

Calculator.convert("(2*2322+23)+3") |> IO.inspect
