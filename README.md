# Evaluate-expression
Evaluate a string expression (or a list) with arithmetic operations

Lua does not have a native evaluation function.
With this code, I implemented evaluation of some basic operations.
And also paranthesis and operator precedence is implemented.

These are the operators currently supported:

"¹²³"   ex: 5¹=5  6²=36 4³=64           (power)

"n"     ex: n5=-5 n10=-10               (n is negate)

"u"     ex: 3u2=9 5u3=125               (u is exponentiate)

"/xmb"  ex: 8/2=4 5x3=15  9m2=1 9b2=4   (divison, multiplication, m is mod, b is integer divison)

"+-"    ex: 77+3=80   5-2=3             (addition and subtraction)


You can input a string like "5x(3³/9)".
There are many examples at the bottom of the code.
