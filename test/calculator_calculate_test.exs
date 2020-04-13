defmodule CalculatorCalculateTest do
  use ExUnit.Case
  doctest Calculator.Calculate 

  assert "do expression" do
    l1 = ["(", "3", "*", "(", "2", "+", "3", ")" ,")"]
    assert Calculator.Calculate.do_expression(l1) == [15.0]
    l2 = ["3", "*", "2", "/", "1"]
    assert Calculator.Calculate.do_expression(l2) == [6.0]
    l1 = ["(", "2", "+", "3", ")", "*", "(", "3" ,"+", "3", ")"]
    assert Calculator.Calculate.do_expression(l1) == [30.0]
  end

end
