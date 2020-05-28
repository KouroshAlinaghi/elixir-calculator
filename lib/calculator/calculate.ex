defmodule Calculator.Calculate do
  import Calculator.Helper

  def do_expression(list) when length(list) == 1, do: list

  def do_expression(list) do
    cond do
      Enum.find_index(list, fn x -> x == "(" end) != nil ->
        i = Enum.find_index(list, fn x -> x == "(" end)
        l = find_close_parentheses(list, 0, 0, 0)
        new_exp = Enum.slice(list, i, l - i) |> remove_parentheses
        res = do_expression(new_exp)
        pre = Enum.take(list, i)
        next = Enum.take(list, l - length(list))
        do_expression(pre ++ res ++ next)

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

  def calc(l, o, r) do
    left_number = to_number(l)
    right_number = to_number(r)

    case o do
      "+" -> left_number + right_number
      "-" -> left_number - right_number
      "*" -> left_number * right_number
      "/" -> left_number / right_number
      "^" -> :math.pow(left_number, right_number)
      _ -> nil
    end
  end
end
