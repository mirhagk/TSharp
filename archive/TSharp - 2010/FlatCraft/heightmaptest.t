var frequency : real := 64
var amplitude : real := 1
var persistence : real := 3
var heightsfinal : array 1 .. maxx of real
var heights : array 0 .. 5 of array 1 .. 1000 of real
for cnt : 0 .. 5
    frequency /= 2
    amplitude := persistence ** cnt
    for i : 1 .. maxx
	heights (cnt) (i) := maxy / 2
    end for
    for i : 2 .. maxx by round (frequency)
	heights (cnt) (i) := heights (cnt) (i - 1) + (Rand.Real * 2 - 1) * persistence
	for j : 1 .. round (frequency) - 1
	    heights (cnt) (i + j) := heights (cnt) (i)
	end for
    end for
    for i : 1 .. maxx by round (frequency)
	for j : 1 .. round (frequency) - 2
	    heights (cnt) (i + j) := heights (cnt) (i) + ((heights (cnt) (i + round (frequency)) - heights (cnt) (i)) / frequency) * j
	end for
    end for
    for i : 1 .. maxx
	Draw.Line (i, round (heights (cnt) (i)), i + 1, round (heights (cnt) (i)), cnt * 20)
    end for
end for
var temp := getchar
for i : 1 .. maxx
    heightsfinal (i) := (heights (0) (i) + heights (1) (i) + heights (2) (i) + heights (3) (i) + heights (4) (i) + heights (5) (i)) / 6
end for
cls
for i : 1 .. maxx
    Draw.Line (i, round (heightsfinal (i)), i + 1, round (heightsfinal (i)), black)
end for
