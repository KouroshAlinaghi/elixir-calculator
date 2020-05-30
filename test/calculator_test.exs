defmodule CalculatorTest do
  use ExUnit.Case
  doctest Calculator

  @nested_parentheses ["(", 3.0, "*", "(", 2.0, "+", 3.0, ")" ,")", "*", "(", 2.0, "+", 32.0, ")"]
  @simple_expression [2.0, "^", 5.0]
  @answer [32.14]
  @string_expression "2 + 343 - -23\n"
  @remove_last_index [232.0, "\n"]
  @unnumbered_expression ["2", "^", "5.0"]
  @bruh [2.0, "(", 5.0, "+", 2.3, ")"]
  @another_bruh ["(", 2.0, "+", 3890,")", "(", 5.0, "+", 2.3, ")"]

  assert "get_answer/1" do
    assert Calculator.get_answer(@answer) == 32.14
  end

  assert "convert_to_list/1" do
    assert Calculator.convert_to_list(@string_expression) === ["2", "+","3", "4", "3", "-", "-", "2", "3", "\n"]
  end

  assert "remove_last_index/1" do
    assert Calculator.remove_last_index(@remove_last_index) === [232.0]
  end

  assert "convert_str_to_num/2" do
    assert Calculator.convert_str_to_num(@unnumbered_expression, 0) == @simple_expression
  end

  assert "add_multiple/2" do
    assert Calculator.add_multiple(@bruh, 0) == [2.0, "*", "(", 5.0, "+", 2.3, ")"]
    assert Calculator.add_multiple(@another_bruh, 0) == ["(", 2.0, "+", 3890,")", "*", "(", 5.0, "+", 2.3, ")"]
  end

  assert "calculate/1" do
    assert Calculator.calculate(@string_expression) === 368.0
  end

end
