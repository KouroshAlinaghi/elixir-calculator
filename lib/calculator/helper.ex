defmodule Calculator.Helper do

  def find_close_parentheses(list, at, l \\ 0, r \\ 0) do
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

  def remove_parentheses(list, i) do
    mir = mir_sli(list, i)
    List.delete_at(list, i) |> List.delete_at(mir - 2)
  end

  def to_number(str) do
    if is_float(str) do
      str
    else
      case Float.parse(str) do
        {num, ""} -> num
        _ -> raise "Invalid Token: #{str}"
      end
    end
  end

  def is_parenthese?(token), do: token == "(" || token == ")"

  def is_operator?(pre), do: Enum.member?(["+", "-", "^", "/", "*"], pre)

  def is_special_operator?(operator), do: Enum.member?(["*", "/", "(", ")"], operator)

  def is_numeric?(str) do
    if str == "." do
      true
    else
      case Float.parse(str) do
        {_num, ""} -> true
        _ -> false
      end
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

