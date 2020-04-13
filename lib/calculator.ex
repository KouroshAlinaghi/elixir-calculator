defmodule Calculator do
  @moduledoc """
  A Simple Calculator, as My First Elixir Project!
  """
  import Calculator.Parser

  def calculate(expression) do
    no_white_spaces = expression |> String.replace(" ", "")
    do_convert(String.split(no_white_spaces, "", trim: true), 0, String.length(no_white_spaces))
  end

  def get_input() do
    input = IO.gets("calc> ")
    List.first(calculate(String.trim(input))) |> IO.puts()
    get_input()
  end
end

IO.puts("Hello, Welcome To My Simple Calculator!")
Calculator.get_input()
