defmodule CalculatorHelperTest do
  use ExUnit.Case
  doctest Calculator.Helper

  @list1 ["1", "/", "(", "3", "*", "(", "2", "+", "3", ")" ,")"]
  @list2 ["(", "3", "*", "(", "2", "+", "3", ")" ,")"]

  test "find_close_parentheses/4" do
    assert Calculator.Helper.find_close_parentheses(@list1, 5, 0, 0) == 10
  end

  test "remove_parentheses/1" do
    assert Calculator.Helper.remove_parentheses(@list2) == ["3", "*", "(", "2", "+", "3", ")"]
  end

  test "to_number/1" do
    assert Calculator.Helper.to_number(23.0) == 23.0
    assert Calculator.Helper.to_number("23") == 23.0
    assert Calculator.Helper.to_number("23.0") == 23.0
  end

end
