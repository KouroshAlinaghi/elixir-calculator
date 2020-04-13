defmodule CalculatorHelperTest do
  use ExUnit.Case
  doctest Calculator.Helper

  test "find close parentheses" do
    list = ["1", "/", "(", "3", "*", "(", "2", "+", "3", ")" ,")"]
    assert Calculator.Helper.find_close_parentheses(list, 5) == 10
  end

  test "remove parentheses" do
    list = ["(", "3", "*", "(", "2", "+", "3", ")" ,")"]
    assert Calculator.Helper.remove_parentheses(list) == ["3", "*", "(", "2", "+", "3", ")"]
  end

end
