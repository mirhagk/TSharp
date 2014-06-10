var heightArr : array 0 .. maxx of int

proc Fractal (start, finish, height : int)
    if (start >= finish) then
	return
    end if
    var midPoint := (finish + start) div 2
    if midPoint = 0 or midPoint = start then
	return
    end if
    var curMaxHeight := heightArr (midPoint) + Rand.Int (-height, height)
    for i : max (start, 1) .. midPoint
	heightArr (i) := round (heightArr (i) + (midPoint - heightArr (i)) * ((i - start) / (midPoint - start)))
    end for

    Fractal (start, midPoint, height div 2)
    Fractal (midPoint + 1, finish, height div 2)
end Fractal

for x : 0 .. maxx
    heightArr (x) := maxy div 2
end for

Fractal (0, maxx, maxy div 2)

for x : 0 .. maxx
    drawfilloval (x, heightArr (x), 1, 1, black)
end for
