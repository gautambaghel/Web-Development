defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "basic summation" do
    assert Calc.eval("2 + 7") == 9
  end

   test "basic substraction" do
    assert Calc.eval("14 - 9") == 5
  end

   test "basic multiplication" do
    assert Calc.eval("12 * 2") == 24
  end

   test "int division" do
    assert Calc.eval("18 / 5") == 3.6
  end

   test "dec division" do
    assert Calc.eval("18 / 6") == 3
  end

  test "basic paranthesis" do
    assert Calc.eval("2 * (18 - 6)") == 24
  end

  test "normal bodmas equation" do
    assert Calc.eval("18 / 3 - 5 * 6") == -24
  end

  test "mix equation 1" do
    assert Calc.eval("24 / 6 + (5 - 4)") == 5
  end

  test "mix equation 2" do
    assert Calc.eval("100 * (3 + 12) / 3 - 5 * 6") == 470
  end

  test "mix equation 3" do
    assert Calc.eval("(30 - 8 * 9 - (50 / 4)) / 3 - 5 * 6") |> Float.ceil(2) == -48.16
  end

  test "token processing" do
    assert Calc.processToken("2",Stack.init 
    	|> Stack.push(1), Stack.init 
    	|> Stack.push("+")) == 
    {Stack.init |> Stack.push(1) |> Stack.push(2.0),
     Stack.init |> Stack.push("+")}
  end

  test "eval method" do
    assert Calc.eval(["2","-","4"],3, Stack.init, Stack.init) == 
    {Stack.init |> Stack.push(-2), Stack.init}
  end

   test "paranthesis method" do
   	operators =  Stack.init |> Stack.push("(") |> Stack.push("+")
   	head = Stack.head(operators)
    assert Calc.processParanthesis(Stack.init |> Stack.push(2.0) |> Stack.push(3.0),operators,head) == 
    {Stack.init |> Stack.push(5), Stack.init}
  end

  test "process Operator method" do
  	operators =  Stack.init |> Stack.push("+")
  	numbers =  Stack.init |> Stack.push(2.0) |> Stack.push(4.0) 
  	assert Calc.processOperator("-",numbers,operators,1) == 
  	{Stack.init |> Stack.push(6.0) ,Stack.init}
  end

  test "operator precedence" do 
  	assert Calc.precedence("-","+") == true
  	assert Calc.precedence("/","+") == false
  	assert Calc.precedence("-","*") == true
  	assert Calc.precedence("/","-") == false
  	assert Calc.precedence("-","(") == false
  	assert Calc.precedence(")","+") == true
  end

  test "evaluate" do 
  	assert Calc.evaluate("-",4,2) == -2
  	assert Calc.evaluate("/",10,12) == 1.2
  	assert Calc.evaluate("+",2,9.0) == 11.0
  	assert Calc.evaluate("*",23,3) == 69
  end

   test "check if it is num" do 
  	assert Calc.isItNum("2") == true
  	assert Calc.isItNum("*") == false
  	assert Calc.isItNum("(") == false
  	assert Calc.isItNum("20.2") == true
  end

   test "Simplify number" do 
  	assert Calc.simplifyNum("4.3") == 4.3
  	assert Calc.simplifyNum("12.0") == 12
  	assert Calc.simplifyNum("123.0") == 123
  	assert Calc.simplifyNum("123.123") == 123.123
  end

  test "Format equation" do 
  	assert Calc.formatString("4.3 * 9 +(2 * 4)",[]) == ["4.3", "*", "9.0", "+", "(", "2.0", "*", "4.0", ")"]
  	assert Calc.formatString("12.0 - 9 * (12 + 123)",[]) == ["12.0", "-", "9.0", "*", "(", "12.0", "+", "123.0", ")"]
  end

  test "Test stack" do 
  	{_,st} = Stack.init 
  	|> Stack.push("7") 
  	|> Stack.push("12") 
  	|> Stack.pop()
    assert st == Stack.init 
  	|> Stack.push("7") 
  end

end
