defmodule CalculatorTest do
  use ExUnit.Case
  doctest Calculator

  test "check some operations" do
    assert Calculator.calculate("2+3*(-2/1)/2") == [-1.0]
    assert Calculator.calculate("(2+3)*(-2/1)/2") == [-5.0]
  end
end
