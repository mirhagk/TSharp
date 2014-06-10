var outputsize : int := 12
var outputscale : real := 16 / outputsize
var blocksimage : int := Pic.FileNew ("modifiedterrain.bmp")
Pic.Draw (blocksimage, 0, 0, picCopy)
var blockoriginals : array 1 .. 14 of int
for i : 1 .. 14
    blockoriginals (i) := Pic.New (0, i * 16 - 16, 15, i * 16 - 1)
end for
var blocknews : array 1 .. 14 of int
var timeorig := Time.Elapsed
var blocknewcolors : array 1 .. 14 of array 1 .. 12 of array 1 .. 12 of array 1 .. 3 of real
for num : 1 .. 14
    RGB.SetColor (69, 1, 1, 1)
    Draw.FillBox (0, 0, maxx, maxy, 69)
    Pic.Draw (blockoriginals (num), 0, 0, picCopy)
    for x : 1 .. outputsize
	for y : 1 .. outputsize
	    for i : 0 .. 255
		RGB.SetColor (i, i / 255, 0, 0)
	    end for
	    blocknewcolors (num) (x) (y) (1) := whatdotcolor (round (x * outputscale) - 1, round (y * outputscale) - 1) / 255
	    for i : 0 .. 255
		RGB.SetColor (i, 0, i / 255, 0)
	    end for
	    blocknewcolors (num) (x) (y) (2) := whatdotcolor (round (x * outputscale) - 1, round (y * outputscale) - 1) / 255
	    for i : 0 .. 255
		RGB.SetColor (i, 0, 0, i / 255)
	    end for
	    blocknewcolors (num) (x) (y) (3) := whatdotcolor (round (x * outputscale) - 1, round (y * outputscale) - 1) / 255
	    RGB.SetColor (69, blocknewcolors (num) (x) (y) (1), blocknewcolors (num) (x) (y) (2), blocknewcolors (num) (x) (y) (3))
	    Draw.Dot (18 + x, y, 69)
	end for
    end for
    blocknews (num) := Pic.New (19, 1, 18 + outputsize, outputsize)
end for
RGB.SetColor (69, 1, 1, 1)
Draw.FillBox (0, 0, maxx, maxy, 69)
for i : 1 .. 14
    Pic.Draw (blocknews (i), i * outputsize - outputsize, 5, picCopy)
end for
