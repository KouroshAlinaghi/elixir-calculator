defmodule Calculator.Helper do

  def find_close_parentheses(_list, at, l, r) when l == r and r != 0, do: at
  def find_close_parentheses(list, at, _l, _r) when at == length(list), do: raise "parenthesis are not balanced"
  def find_close_parentheses(list, at, l, r) do
    case Enum.at(list, at) do
      "(" -> find_close_parentheses(list, at + 1, l + 1, r)
      ")" -> find_close_parentheses(list, at + 1, l, r + 1)
      _ -> find_close_parentheses(list, at + 1, l, r)
    end
  end

  def remove_parentheses(list), do: List.delete_at(list, 0) |> List.delete_at(length(list) - 2)

  def to_number(token) when is_float(token), do: token
  def to_number(token) do
    case Float.parse(token) do
      {num, ""} -> num
      _ -> raise "cannot parse, near: #{token}"
    end
  end

  def is_parenthese?(token) when token in ["(", ")"], do: true
  def is_parenthese?(_token), do: false

  def is_operator?(token) when token in ["+", "-", "^", "/", "*"], do: true
  def is_operator?(_token), do: false

  def is_special_operator?(operator) when operator in ["*", "/", "(", ")"], do: true
  def is_special_operator?(_operator), do: false

  def is_numeric?("."), do: true
  def is_numeric?(str) do
    case Float.parse(str) do
      {_num, ""} -> true
      _ -> false
    end
  end

  def are_numbers?(a, b) do
    if is_numeric?(a) && is_numeric?(b) do
      true
    else
      false
    end
  end
end
