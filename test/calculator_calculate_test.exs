defmodule CalculatorTest do
  use ExUnit.Case
  doctest Calculator.Calculate 

  @nested_parentheses ["(", 3.0, "*", "(", 2.0, "+", 3.0, ")" ,")", "*", "(", 2.0, "+", 32.0, ")"]
  @simple_expression [2.0, "^", 5.0]
  @answer [32.14]

  assert "calculate_expression/1" do
    assert Calculator.Calculate.calculate_expression(@nested_parentheses) == [510.0]
    assert Calculator.Calculate.calculate_expression(@simple_expression) == [32.0]
    assert Calculator.Calculate.calculate_expression(@answer) == [32.14]
  end

end
