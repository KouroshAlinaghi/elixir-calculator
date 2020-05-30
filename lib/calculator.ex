defmodule Calculator do
  @moduledoc """
  A Simple Calculator, as My First Elixir Project!
  """

  import Calculator.{Calculate, Parser, Helper}

  def convert_to_list(expression) do
    expression
    |> String.replace(" ", "")
    |> String.split("", trim: true)
  end

  def remove_last_index(list), do: List.delete_at(list, length(list)-1)

  def convert_str_to_num(list, i) when i == length(list), do: list
  def convert_str_to_num(list, i) do
    if is_operator?(Enum.at(list, i)) || is_parenthese?(Enum.at(list, i)) do
      convert_str_to_num(list, i+1)
    else
      List.update_at(list, i, fn token -> to_number(token) end)
      |> convert_str_to_num(i+1)
    end
  end

  def add_multiple(list, i) when i == length(list), do: list
  def add_multiple(list, i) do
    if (is_float(Enum.at(list,i)) && Enum.at(list,i+1)=="(") || (Enum.at(list,i)==")" && Enum.at(list,i+1)=="(") do
      list
      |> List.insert_at(i+1, "*")
      |> add_multiple(i+1)
    else
      add_multiple(list, i+1)
    end
  end

  def get_answer([answer]), do: answer

  def main() do
    IO.gets("calc> ")
    |> calculate()
    |> IO.inspect
    main()
  end

  def calculate(expression) do
    expression
    |> convert_to_list()
    |> remove_last_index()
    |> do_convert(0)
    |> merge_negative_with_numbers(0)
    |> convert_str_to_num(0)
    |> add_multiple(0)
    |> calculate_expression()
    |> get_answer()
  end
end

#IO.puts("Hello, Welcome To My Simple Calculator!")
#Calculator.main() 
