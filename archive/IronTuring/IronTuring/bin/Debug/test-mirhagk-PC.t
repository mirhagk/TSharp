var num := 5 + 5 - 5 * 5
put num, 6
var name : string
var price : real := 5.01
var things : array 0 .. 9 of array 0 .. 9 of int
put price
price := price * 2.0
put price

function square (num : int, unused : real) : int
    result num * num
end square

put square (5, 5.001)
