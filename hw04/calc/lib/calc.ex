defmodule Calc do

  @moduledoc """
  Documentation for Calc.
  """
  def main do
     IO.write "> " 
     IO.read(:line) |> eval |> IO.puts
     main()
  end

  def eval(exp) do  

      numbers = Stack.init
      operators = Stack.init

      recievedString = exp |> String.trim |> String.replace(" ","") |> String.replace("+"," + ")|> String.replace("-"," - ")
      elements = formatString(recievedString,[])
      runUntil = length(elements)

      {numbers, _} = eval(elements, runUntil, numbers, operators)
       numbers |> Stack.head() |> to_string |> simplifyNum
  end

  def eval(numbers, operators) do
     if !Stack.is_empty(operators) do
       processOperator(:none,numbers,operators,Stack.size(operators))
     else
       {numbers, operators}
     end
 end

  def eval(elements, n, numbers, operators) when n <= 1 do 
      [head | _] = elements
      {numbers,operators} = processToken(head,numbers,operators)
      eval(numbers, operators)
  end

  def eval(elements, n, numbers, operators) do 
      [head | tail] = elements
      {numbers, operators} = processToken(head,numbers,operators)
      eval(tail, n-1, numbers, operators)
  end

  def processToken(token, numbers, operators) do
    cond do
        isItNum(token) ->
          {num, ""} = Float.parse(token)
          {Stack.push(numbers, num), operators}
        token == "(" ->
          {numbers, Stack.push(operators, (token))}
        token == ")" ->
          processParanthesis(numbers,operators,Stack.head(operators))
        token == "/" || token == "*" || token == "+" || token == "-" ->
          {numbers, operators} =
          if !Stack.is_empty(operators) do
            processOperator(token,numbers,operators,Stack.size(operators))
          else
            {numbers, operators} 
          end
            {numbers, Stack.push(operators, token)}
    end 
  end
   
  def processParanthesis(numbers, operators, head) when head == "(" do
    {_, operators} = Stack.pop(operators)
    {numbers, operators}
  end 

  def processParanthesis(numbers, operators, _) do
     {op, operators} = Stack.pop(operators)
     {lhs, numbers} = Stack.pop(numbers)
     {rhs, numbers} = Stack.pop(numbers)
     numbers = Stack.push(numbers,evaluate(op,lhs,rhs))
     processParanthesis(numbers, operators,Stack.head(operators))
  end 

  def processOperator(token,numbers,operators,n) when n <= 1 do  
    if precedence(token,Stack.head(operators)) && !Stack.is_empty(operators)  do
        {op, operators} = Stack.pop(operators)
        {lhs, numbers} = Stack.pop(numbers)
        {rhs, numbers} = Stack.pop(numbers)    
        {Stack.push(numbers,evaluate(op,lhs,rhs)), operators}
    else 
        {numbers, operators}    
    end
  end

  def processOperator(token,numbers,operators,n) do 
    cond do
      !Stack.is_empty(operators) && token == :none -> 
        {op, operators} = Stack.pop(operators)
        {lhs, numbers} = Stack.pop(numbers)
        {rhs, numbers} = Stack.pop(numbers)
        numbers = Stack.push(numbers,evaluate(op,lhs,rhs))
        processOperator(token,numbers,operators,n-1)

      !Stack.is_empty(operators) && precedence(token,Stack.head(operators)) -> 

        {op, operators} = Stack.pop(operators)
        {lhs, numbers} = Stack.pop(numbers)
        {rhs, numbers} = Stack.pop(numbers)
        numbers = Stack.push(numbers,evaluate(op,lhs,rhs))
        processOperator(token,numbers,operators,n-1)

      true -> processOperator(token,numbers,operators,n-1)
    end
  end

   def precedence(op1 , op2) do
     cond do
       op2 == "(" || op2 == ")" ->
        false
       (op1 == "*" || op1 == "/") && (op2 == "+" || op2 == "-") ->
        false
       true ->
        true
     end
   end

  def evaluate(op, rhs, lhs) do
    case op do
      "+" -> lhs + rhs
      "-" -> lhs - rhs
      "/" -> lhs / rhs
      "*" -> lhs * rhs
    end
  end

  def isItNum(s) do 
        maybeNum = Float.parse(s)
        case maybeNum do
          :error -> false
          {_, ""} -> true
        end
   end

   def simplifyNum(s) do
    [_ , dec] = String.split(s,".")
    parseVal = 
     if dec == "0" do
          Integer.parse(s)
        else
          Float.parse(s)
     end
    {num, _} = parseVal
     num
   end

   def formatString(s,elems) do
        case Float.parse(s) do
          {head, rest} -> 
            elems = elems ++ [to_string(head)]
            formatString(rest,elems)
          :error -> 
              cond do
                s == "" -> elems
                String.first(s) == " " -> 
                    rest = String.slice(s,1..1500)
                    formatString(rest,elems)
                true -> head = String.first(s)
                    rest = String.slice(s,1..1500)
                    elems = elems ++ [head]
                    formatString(rest,elems)
              end
        end
   end

end


defmodule Stack do
  defstruct elems: []

  def init() do
    %Stack{}  
  end

  def push(stack, elem) do
    %Stack{stack | elems: [elem | stack.elems]}
  end

  def is_empty(stack) do
     cond do 
       stack == %Stack{} -> true
       true -> false
     end
  end

  def head(%Stack{elems: [head | _]}) do 
     head   
  end

  def pop(%Stack{elems: []}) do
     raise("Stack empty!")
  end

  def pop(%Stack{elems: [head | body]}) do
     {head, %Stack{elems: body}}
  end

  def size(%Stack{elems: elems}) do
     length(elems)
  end
end