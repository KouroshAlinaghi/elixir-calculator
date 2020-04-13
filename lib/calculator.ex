defmodule Calculator do
  
  @moduledoc """
  Documentation for `Calculator`.
  """

  @doc """

  ## Examples

  """

  import Calculator.Parser

  def calculate(expression) do
    no_white_spaces = expression |> String.replace(" ", "")
    do_convert(String.split(no_white_spaces, "", trim: true), 0, String.length(no_white_spaces))
  end

end

Calculator.calculate("7+3*-2+3*(3-2*-292)") |> IO.inspect
