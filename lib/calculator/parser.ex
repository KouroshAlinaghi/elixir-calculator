defmodule Calculator.Parser do

  import Calcualtor.Calculate 
  import Calculator.Helper

  def do_convert(exp, i, exp_length) when i == exp_length - 1 do
    if Enum.member?(exp, "-") do
      allow_negative(exp, 0)
    else
      do_expression(exp)
    end
  end

  def do_convert(exp, i, _exp_length) do
    cur = Enum.at(exp, i) 
    nex = Enum.at(exp, i + 1) 

    cond do
      are_numbers?(String.last(cur), nex) ->
        new_exp = List.update_at(exp, i + 1, fn _x -> cur <> nex end) |> List.delete_at(i)
        do_convert(new_exp, i, length(new_exp))

      true ->
        do_convert(exp, i + 1, length(exp))
    end
  end

  def allow_negative(list, 0) do
    cur = Enum.at(list, 0) 
    nex = Enum.at(list, 1) 
    nexnex = Enum.at(list, 2) 
    cond do
      cur == "-" && is_numeric?(nex) -> 
        allow_negative(List.update_at(list, 0, fn _x -> cur <> nex end) |> List.delete_at(1), 1)
      cur == "(" && nex == "-" && is_numeric?(nexnex) ->
        allow_negative(List.update_at(list, 1, fn _x -> nex <> nexnex end) |> List.delete_at(2), 1)
      cur != "-" ->
        allow_negative(list, 1)
      true -> raise "Please Enter Valid Expression"
    end
  end

  def allow_negative(list, i) do
    if i == length(list) do
      do_expression(list)
    else
      pre = Enum.at(list, i-1) 
      cur = Enum.at(list, i) 
      nex = Enum.at(list, i+1) 
      if cur == "-" && is_numeric?(nex) && (is_operator?(pre)|| pre == "(") do
        allow_negative(List.update_at(list, i, fn _x -> cur <> nex end) |> List.delete_at(i+1), i+1)
      else 
        allow_negative(list, i+1)
      end
    end
  end

end
