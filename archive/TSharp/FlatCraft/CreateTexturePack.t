var timeorig := Time.Elapsed
var numblocks : int
var stream : int
open : stream, "datafiles/NumBlocks.txt", get
get : stream, numblocks
var picture : int := Pic.FileNew ("images/terrain.gif")
setscreen ("offscreenonly")
var darkness := 0
var darkscale : real := 0.075
var images : array 1 .. numblocks of array 0 .. 10 of int
var tobecreated : array 1 .. numblocks of array 1 .. 2 of int
open : stream, "datafiles/blocks.txt", get
var ids, xs, ys : string
var id : int
loop
    exit when eof (stream)
    get : stream, ids : *
    var temp : string := ""
    var idtemp : string := ""
    for i : 1 .. length (ids)
	if ids (i) not= "*" then
	    idtemp += ids (i)
	end if
    end for
    id := strint (idtemp)
    get : stream, temp : *
    get : stream, xs : *
    tobecreated (id) (1) := strint (xs (5 .. length (xs)))
    get : stream, ys : *
    tobecreated (id) (2) := strint (ys (5 .. length (ys)))
    get : stream, temp : *
    get : stream, temp : *
    get : stream, temp : *
    get : stream, temp : *
    get : stream, temp : *
end loop
var picx, picy : int
for num : 1 .. upper (tobecreated)
    darkness := 1
    picx := tobecreated (num) (1)
    picy := tobecreated (num) (2)
    Pic.Draw (picture, 0, 0, picCopy)
    images (num) (0) := Pic.New (picx, picy, picx + 15, picy + 15)
    for d : 0 .. 10
	Pic.Draw (picture, 0, 0, picCopy)
	View.Update
	var reds : array 0 .. 15 of array 0 .. 15 of real
	var blues : array 0 .. 15 of array 0 .. 15 of real
	var greens : array 0 .. 15 of array 0 .. 15 of real
	var temp : real
	for i : 0 .. 255
	    RGB.SetColor (i, i, 0, 0)
	end for
	for a : 0 .. 15
	    for b : 0 .. 15
		var colorr : int := whatdotcolor (picx + a, picy + b)
		RGB.GetColor (colorr, reds (a) (b), temp, temp)
	    end for
	end for
	for i : 0 .. 255
	    RGB.SetColor (i, 0, i, 0)
	end for
	for a : 0 .. 15
	    for b : 0 .. 15
		var colorr : int := whatdotcolor (picx + a, picy + b)
		RGB.GetColor (colorr, temp, greens (a) (b), temp)
	    end for
	end for
	for i : 0 .. 255
	    RGB.SetColor (i, 0, 0, i)
	end for
	for a : 0 .. 15
	    for b : 0 .. 15
		var colorr : int := whatdotcolor (picx + a, picy + b)
		RGB.GetColor (colorr, temp, temp, blues (a) (b))
	    end for
	end for
	for x : 0 .. 15
	    for y : 0 .. 15
		var redcolor, greencolor, bluecolor : real
		redcolor := reds (x) (y) - (darkscale * darkness)
		greencolor := greens (x) (y) - (darkscale * darkness)
		bluecolor := blues (x) (y) - (darkscale * darkness)
		if redcolor < 0 then
		    redcolor := 0
		end if
		if greencolor < 0 then
		    greencolor := 0
		end if
		if bluecolor < 0 then
		    bluecolor := 0
		end if
		RGB.SetColor (0, redcolor, greencolor, bluecolor)
		if num = 14 then
		    RGB.SetColor (0, 0, greencolor, 0)
		end if
		if reds (x) (y) = 1 and greens (x) (y) = 1 and blues (x) (y) = 1 then
		    RGB.SetColor (255, 1, 1, 1)
		    Draw.Dot (picx + x, picy + y, 255)
		else
		    Draw.Dot (picx + x, picy + y, 0)
		end if
	    end for
	end for
	View.Update
	images (num) (d) := Pic.New (picx, picy, picx + 15, picy + 15)
	darkness += 1
    end for
end for
RGB.SetColor (0, 1, 1, 1)
cls
var outputsize : int := 12
var outputscale : real := 16 / outputsize
var blockoriginals : array 1 .. numblocks of int
for i : 1 .. numblocks
    blockoriginals (i) := images (i) (0)
end for
var blocknews : array 1 .. numblocks of int
var blocknewcolors : array 1 .. numblocks of array 1 .. 12 of array 1 .. 12 of array 1 .. 3 of real
for num : 1 .. numblocks
    RGB.SetColor (69, 1, 1, 1)
    Draw.FillBox (0, 0, maxx, maxy, 69)
    Pic.Draw (blockoriginals (num), 0, 0, picCopy)
    View.Update
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
    View.Update
    blocknews (num) := Pic.New (19, 1, 18 + outputsize, outputsize)
end for
RGB.SetColor (69, 1, 1, 1)
Draw.FillBox (0, 0, maxx, maxy, 69)












var itemoriginals : flexible array 1 .. 0 of int
var itemspicture := Pic.FileNew ("images/items.gif")
Pic.Draw (itemspicture, 0, 0, picMerge)

open : stream, "datafiles/tools.txt", get
loop
    exit when eof (stream)
    var temp : string := ""
    get : stream, temp : *
    get : stream, temp : *
    var x, y : int
    get : stream, xs : *
    x := strint (xs (5 .. length (xs)))
    get : stream, ys : *
    y := strint (ys (5 .. length (ys)))
    new itemoriginals, upper (itemoriginals) + 1
    itemoriginals (upper (itemoriginals)) := Pic.New (x, y, x + 15, y + 15)
    get : stream, temp : *
    get : stream, temp : *
    get : stream, temp : *
    get : stream, temp : *
    get : stream, temp : *
    get : stream, temp : *
end loop











/*
 var itemnews : array 1 .. upper (itemoriginals) of int
 var itemnewcolors : array 1 .. upper (itemoriginals) of array 1 .. 12 of array 1 .. 12 of array 1 .. 3 of real
 for num : 1 .. upper (itemoriginals)
 RGB.SetColor (69, 1, 1, 1)
 Draw.FillBox (0, 0, maxx, maxy, 69)
 Pic.Draw (itemoriginals (num), 0, 0, picCopy)
 View.Update
 for x : 1 .. outputsize
 for y : 1 .. outputsize
 for i : 0 .. 255
 RGB.SetColor (i, i / 255, 0, 0)
 end for
 itemnewcolors (num) (x) (y) (1) := whatdotcolor (round (x * outputscale) - 1, round (y * outputscale) - 1) / 255
 for i : 0 .. 255
 RGB.SetColor (i, 0, i / 255, 0)
 end for
 itemnewcolors (num) (x) (y) (2) := whatdotcolor (round (x * outputscale) - 1, round (y * outputscale) - 1) / 255
 for i : 0 .. 255
 RGB.SetColor (i, 0, 0, i / 255)
 end for
 itemnewcolors (num) (x) (y) (3) := whatdotcolor (round (x * outputscale) - 1, round (y * outputscale) - 1) / 255
 RGB.SetColor (69, itemnewcolors (num) (x) (y) (1), itemnewcolors (num) (x) (y) (2), itemnewcolors (num) (x) (y) (3))
 Draw.Dot (18 + x, y, 69)
 end for
 end for
 View.Update
 itemnews (num) := Pic.New (19, 1, 18 + outputsize, outputsize)
 end for




 */

RGB.SetColor (69, 1, 1, 1)
Draw.FillBox (0, 0, maxx, maxy, 69)
for i : 1 .. numblocks
    for j : 0 .. 10
	Pic.Draw (images (i) (j), j * 16, i * 16 - 16, picCopy)
    end for
    Pic.Draw (blocknews (i), 180, i * 16 - 16, picCopy)
end for
for i : 1 .. 12
    for j : 1 .. ceil (upper (itemoriginals) / 12)
	if j * 12 - 12 + i <= upper (itemoriginals) then
	    Pic.Draw (itemoriginals (j * 12 - 12 + i), i * 16 - 16, upper (blocknews) * 16 + j * 16 - 16, picCopy)
	end if
    end for
end for
View.Update
var finalimage : int := Pic.New (0, 0, 180 + outputsize, upper (tobecreated) * 16 + 16 * ceil (upper (itemoriginals) / 12))
Pic.Save (finalimage, "images/modifiedterrain.bmp")
color (255)
put Time.Elapsed - timeorig
