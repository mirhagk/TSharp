%Excuse the horribly bad organization and practice of this file, I had not time to rewrite it.
Dir.Change (maindirectory)
%Rest variables
var holdingblock : int := 0
var holdingamount : int := 0
var output : item
output.id := 0
output.amount := 0
var leftheld : boolean := false
var rightheld : boolean := false
var height, ascent, descent, internalLeading : int
var font : int := Font.New ("Impact:8")
Font.Sizes (font, height, ascent, descent, internalLeading)
Mouse.ButtonChoose ("multibutton")
Time.Delay (100)
loop
%Draws background
    Pic.Draw (craftingbackground, 0, 0, picCopy)
    %Gets input
    Input.KeyDown (chars)
    Mouse.Where (x, y, button)
    %Draws screen
    Pic.Draw (craftingscreen, maxx div 2 - 176 div 2, maxy div 2 - 166 div 2, picCopy)
    %Draws items
    for i : 1 .. 9
	if inventory (i).id not= 0 then
	    Pic.Draw (textures (inventory (i).id) (0), maxx div 2 - 176 div 2 + 6 + i * 16 + i * 2 - 16, maxy div 2 - 166 div 2 + 8, picMerge)
	    Font.Draw (intstr (inventory (i).amount), maxx div 2 - 176 div 2 + 6 + i * 16 + i * 2 - 16 + 1, maxy div 2 - 166 div 2 + 9, font, white)
	end if
    end for
    for i : 10 .. 18
	if inventory (i).id not= 0 then
	    Pic.Draw (textures (inventory (i).id) (0), maxx div 2 - 176 div 2 + 6 + (i - 9) * 16 + (i - 9) * 2 - 16, maxy div 2 - 166 div 2 + 26 + 4, picMerge)
	    Font.Draw (intstr (inventory (i).amount), maxx div 2 - 176 div 2 + 6 + (i - 9) * 16 + (i - 9) * 2 - 16 + 1, maxy div 2 - 166 div 2 + 27 + 4, font, white)
	end if
    end for
    for i : 19 .. 27
	if inventory (i).id not= 0 then
	    Pic.Draw (textures (inventory (i).id) (0), maxx div 2 - 176 div 2 + 6 + (i - 18) * 16 + (i - 18) * 2 - 16, maxy div 2 - 166 div 2 + 44 + 4, picMerge)
	    Font.Draw (intstr (inventory (i).amount), maxx div 2 - 176 div 2 + 6 + (i - 18) * 16 + (i - 18) * 2 - 16 + 1, maxy div 2 - 166 div 2 + 45 + 4, font, white)
	end if
    end for
    for i : 28 .. 36
	if inventory (i).id not= 0 then
	    Pic.Draw (textures (inventory (i).id) (0), maxx div 2 - 176 div 2 + 6 + (i - 27) * 16 + (i - 27) * 2 - 16, maxy div 2 - 166 div 2 + 62 + 4, picMerge)
	    Font.Draw (intstr (inventory (i).amount), maxx div 2 - 176 div 2 + 6 + (i - 27) * 16 + (i - 27) * 2 - 16 + 1, maxy div 2 - 166 div 2 + 63 + 4, font, white)
	end if
    end for
    for i : 1 .. 3
	if craftingtable (1) (i).id not= 0 then
	    Pic.Draw (textures (craftingtable (1) (i).id) (0), maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2, maxy div 2 + 50, picMerge)
	    Font.Draw (intstr (craftingtable (1) (i).amount), maxx div 2 - 58 + i * 16 + i * 2 - 16 - 1, maxy div 2 + 51, font, white)
	end if
    end for
    for i : 1 .. 3
	if craftingtable (2) (i).id not= 0 then
	    Pic.Draw (textures (craftingtable (2) (i).id) (0), maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2, maxy div 2 + 32, picMerge)
	    Font.Draw (intstr (craftingtable (2) (i).amount), maxx div 2 - 58 + i * 16 + i * 2 - 16 - 1, maxy div 2 + 33, font, white)
	end if
    end for
    for i : 1 .. 3
	if craftingtable (3) (i).id not= 0 then
	    Pic.Draw (textures (craftingtable (3) (i).id) (0), maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2, maxy div 2 + 14, picMerge)
	    Font.Draw (intstr (craftingtable (3) (i).amount), maxx div 2 - 58 + i * 16 + i * 2 - 16 - 1, maxy div 2 + 15, font, white)
	end if
    end for
    if output.id not= 0 and output.amount not= 0 then
	Pic.Draw (textures (output.id) (0), maxx div 2 + 36, maxy div 2 + 32, picMerge)
	Font.Draw (intstr (output.amount), maxx div 2 + 37, maxy div 2 + 33, font, white)
    end if
    if holdingblock not= 0 then
	Pic.Draw (textures (holdingblock) (0), x - 8, y - 8, picMerge)
	Font.Draw (intstr (holdingamount), x - 7, y - 7, font, white)
	var width := Font.Width (blockinfos (holdingblock).name, font)
	if blockinfos (holdingblock).name not= "" then
	    Draw.FillBox (x + 7, y - 8, x + 8 + width, y - 6 + ascent - descent, black)
	end if
	Font.Draw (blockinfos (holdingblock).name, x + 8, y - 7, font, white)
    end if

    /*    */

%Draws labels
    for i : 1 .. 9
	if x > maxx div 2 - 176 div 2 + 6 + i * 16 + i * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + i * 16 + i * 2 - 16 + 16 and y > maxy div 2 - 166 div 2 +
		8 and y < maxy div 2
		- 166 div 2 + 8 + 16 then
	    var width := Font.Width (blockinfos (inventory (i).id).name, font)
	    if blockinfos (inventory (i).id).name not= "" then
		Draw.FillBox (x + 7, y - 8, x + 8 + width, y - 6 + ascent - descent, black)
	    end if
	    Font.Draw (blockinfos (inventory (i).id).name, x + 8, y - 7, font, white)
	    exit
	end if
    end for
    for i : 10 .. 18
	if x > maxx div 2 - 176 div 2 + 6 + (i - 9) * 16 + (i - 9) * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + (i - 9) * 16 + (i - 9) * 2 - 16 + 16 and y >
		maxy div 2 - 166 div
		2 + 26 + 4 and y < maxy div 2
		- 166 div 2 + 26 + 16 + 4 then
	    var width := Font.Width (blockinfos (inventory (i).id).name, font)
	    if blockinfos (inventory (i).id).name not= "" then
		Draw.FillBox (x + 7, y - 8, x + 8 + width, y - 6 + ascent - descent, black)
	    end if
	    Font.Draw (blockinfos (inventory (i).id).name, x + 8, y - 7, font, white)
	    exit
	end if
    end for
    for i : 19 .. 27
	if x > maxx div 2 - 176 div 2 + 6 + (i - 18) * 16 + (i - 18) * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + (i - 18) * 16 + (i - 18) * 2 - 16 + 16 and y
		> maxy div 2 - 166
		div 2 + 44 + 4 and y < maxy div 2
		- 166 div 2 + 44 + 16 + 4 then
	    var width := Font.Width (blockinfos (inventory (i).id).name, font)
	    if blockinfos (inventory (i).id).name not= "" then
		Draw.FillBox (x + 7, y - 8, x + 8 + width, y - 6 + ascent - descent, black)
	    end if
	    Font.Draw (blockinfos (inventory (i).id).name, x + 8, y - 7, font, white)
	    exit
	end if
    end for
    for i : 28 .. 36
	if x > maxx div 2 - 176 div 2 + 6 + (i - 27) * 16 + (i - 27) * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + (i - 27) * 16 + (i - 27) * 2 - 16 + 16 and y
		> maxy div 2 - 166
		div 2 + 62 + 4 and y < maxy div 2
		- 166 div 2 + 62 + 16 + 4 then
	    var width := Font.Width (blockinfos (inventory (i).id).name, font)
	    if blockinfos (inventory (i).id).name not= "" then
		Draw.FillBox (x + 7, y - 8, x + 8 + width, y - 6 + ascent - descent, black)
	    end if
	    Font.Draw (blockinfos (inventory (i).id).name, x + 8, y - 7, font, white)
	    exit
	end if
    end for
    for i : 1 .. 3
	if x > maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 and y < maxy div 2 + 50 + 16 and x < maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 + 16 and y > maxy div 2
		+ 50 then
	    var width := Font.Width (blockinfos (craftingtable (1) (i).id).name, font)
	    if blockinfos (craftingtable (1) (i).id).name not= "" then
		Draw.FillBox (x + 7, y - 8, x + 8 + width, y - 6 + ascent - descent, black)
	    end if
	    Font.Draw (blockinfos (craftingtable (1) (i).id).name, x + 8, y - 7, font, white)
	    exit
	end if
    end for
    for i : 1 .. 3
	if x > maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 and y < maxy div 2 + 32 + 16 and x < maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 + 16 and y > maxy div 2
		+ 32 then
	    var width := Font.Width (blockinfos (craftingtable (2) (i).id).name, font)
	    if blockinfos (craftingtable (2) (i).id).name not= "" then
		Draw.FillBox (x + 7, y - 8, x + 8 + width, y - 6 + ascent - descent, black)
	    end if
	    Font.Draw (blockinfos (craftingtable (2) (i).id).name, x + 8, y - 7, font, white)
	    exit
	end if
    end for
    for i : 1 .. 3
	if x > maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 and y < maxy div 2 + 14 + 16 and x < maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 + 16 and y > maxy div 2
		+ 14
		then
	    var width := Font.Width (blockinfos (craftingtable (3) (i).id).name, font)
	    if blockinfos (craftingtable (3) (i).id).name not= "" then
		Draw.FillBox (x + 7, y - 8, x + 8 + width, y - 6 + ascent - descent, black)
	    end if
	    Font.Draw (blockinfos (craftingtable (3) (i).id).name, x + 8, y - 7, font, white)
	    exit
	end if
    end for
    if x > maxx div 2 + 36 and x < maxx div 2 + 36 + 16 and y > maxy div 2 + 32 and y < maxy div 2 + 32 + 16 then
	if output.id not= 0 and output.amount > 0 then
	    var width := Font.Width (blockinfos (output.id).name, font)
	    if blockinfos (output.id).name not= "" then
		Draw.FillBox (x + 7, y - 8, x + 8 + width, y - 6 + ascent - descent, black)
	    end if
	    Font.Draw (blockinfos (output.id).name, x + 8, y - 7, font, white)
	end if
    end if

    /*               */
    %Left click interaction
    if button = 1 and leftheld = false then
    %output interaction
	if x > maxx div 2 + 36 and x < maxx div 2 + 36 + 16 and y > maxy div 2 + 32 and y < maxy div 2 + 32 + 16 then
	    if output.id not= 0 and output.amount > 0 then
		if holdingblock = 0 or holdingblock = output.id then
		    crafttableupdate (craftingtable)
		    holdingblock := output.id
		    holdingamount += output.amount
		end if
	    end if
	end if
	if holdingblock = 0 then
	    for i : 1 .. 9
		if x > maxx div 2 - 176 div 2 + 6 + i * 16 + i * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + i * 16 + i * 2 - 16 + 16 and y > maxy div 2 - 166 div 2 +
			8 and y < maxy div 2
			- 166 div 2 + 8 + 16 then
		    holdingblock := inventory (i).id
		    holdingamount := inventory (i).amount
		    inventory (i).id := 0
		    inventory (i).amount := 0
		    exit
		end if
	    end for
	    for i : 10 .. 18
		if x > maxx div 2 - 176 div 2 + 6 + (i - 9) * 16 + (i - 9) * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + (i - 9) * 16 + (i - 9) * 2 - 16 + 16 and y >
			maxy div 2 - 166 div
			2 + 26 + 4 and y < maxy div 2
			- 166 div 2 + 26 + 16 + 4 then
		    holdingblock := inventory (i).id
		    holdingamount := inventory (i).amount
		    inventory (i).id := 0
		    inventory (i).amount := 0
		    exit
		end if
	    end for
	    for i : 19 .. 27
		if x > maxx div 2 - 176 div 2 + 6 + (i - 18) * 16 + (i - 18) * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + (i - 18) * 16 + (i - 18) * 2 - 16 + 16 and y
			> maxy div 2 - 166
			div 2 + 44 + 4 and y < maxy div 2
			- 166 div 2 + 44 + 16 + 4 then
		    holdingblock := inventory (i).id
		    holdingamount := inventory (i).amount
		    inventory (i).id := 0
		    inventory (i).amount := 0
		    exit
		end if
	    end for
	    for i : 28 .. 36
		if x > maxx div 2 - 176 div 2 + 6 + (i - 27) * 16 + (i - 27) * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + (i - 27) * 16 + (i - 27) * 2 - 16 + 16 and y
			> maxy div 2 - 166
			div 2 + 62 + 4 and y < maxy div 2
			- 166 div 2 + 62 + 16 + 4 then
		    holdingblock := inventory (i).id
		    holdingamount := inventory (i).amount
		    inventory (i).id := 0
		    inventory (i).amount := 0
		    exit
		end if
	    end for
	    for i : 1 .. 3
		if x > maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 and y < maxy div 2 + 50 + 16 and x < maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 + 16 and y > maxy div 2
			+ 50 then
		    holdingblock := craftingtable (1) (i).id
		    holdingamount := craftingtable (1) (i).amount
		    craftingtable (1) (i).id := 0
		    craftingtable (1) (i).amount := 0
		    exit
		end if
	    end for
	    for i : 1 .. 3
		if x > maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 and y < maxy div 2 + 32 + 16 and x < maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 + 16 and y > maxy div 2
			+ 32 then
		    holdingblock := craftingtable (2) (i).id
		    holdingamount := craftingtable (2) (i).amount
		    craftingtable (2) (i).id := 0
		    craftingtable (2) (i).amount := 0
		    exit
		end if
	    end for
	    for i : 1 .. 3
		if x > maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 and y < maxy div 2 + 14 + 16 and x < maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 + 16 and y > maxy div 2
			+ 14
			then
		    holdingblock := craftingtable (3) (i).id
		    holdingamount := craftingtable (3) (i).amount
		    craftingtable (3) (i).id := 0
		    craftingtable (3) (i).amount := 0
		    exit
		end if
	    end for
	else
	    for i : 1 .. 9
		if x > maxx div 2 - 176 div 2 + 6 + i * 16 + i * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + i * 16 + i * 2 - 16 + 16 and y > maxy div 2 - 166 div 2 +
			8 and y < maxy div 2
			- 166 div 2 + 8 + 16 then
		    if inventory (i).id = holdingblock then
			inventory (i).amount += holdingamount
			holdingblock := 0
			holdingamount := 0
		    else
			var tempid : int := inventory (i).id
			var tempamount : int := inventory (i).amount
			inventory (i).id := holdingblock
			inventory (i).amount := holdingamount
			holdingblock := tempid
			holdingamount := tempamount
		    end if
		    exit
		end if
	    end for
	    for i : 10 .. 18
		if x > maxx div 2 - 176 div 2 + 6 + (i - 9) * 16 + (i - 9) * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + (i - 9) * 16 + (i - 9) * 2 - 16 + 16 and y >
			maxy div 2 - 166 div
			2 + 26 + 4 and y < maxy div 2
			- 166 div 2 + 26 + 16 + 4 then
		    if inventory (i).id = holdingblock then
			inventory (i).amount += holdingamount
			holdingblock := 0
			holdingamount := 0
		    else
			var tempid : int := inventory (i).id
			var tempamount : int := inventory (i).amount
			inventory (i).id := holdingblock
			inventory (i).amount := holdingamount
			holdingblock := tempid
			holdingamount := tempamount
		    end if
		    exit
		end if
	    end for
	    for i : 19 .. 27
		if x > maxx div 2 - 176 div 2 + 6 + (i - 18) * 16 + (i - 18) * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + (i - 18) * 16 + (i - 18) * 2 - 16 + 16 and y
			> maxy div 2 - 166
			div 2 + 44 + 4 and y < maxy div 2
			- 166 div 2 + 44 + 16 + 4 then
		    if inventory (i).id = holdingblock then
			inventory (i).amount += holdingamount
			holdingblock := 0
			holdingamount := 0
		    else
			var tempid : int := inventory (i).id
			var tempamount : int := inventory (i).amount
			inventory (i).id := holdingblock
			inventory (i).amount := holdingamount
			holdingblock := tempid
			holdingamount := tempamount
		    end if
		    exit
		end if
	    end for
	    for i : 28 .. 36
		if x > maxx div 2 - 176 div 2 + 6 + (i - 27) * 16 + (i - 27) * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + (i - 27) * 16 + (i - 27) * 2 - 16 + 16 and y
			> maxy div 2 - 166
			div 2 + 62 + 4 and y < maxy div 2
			- 166 div 2 + 62 + 16 + 4 then
		    if inventory (i).id = holdingblock then
			inventory (i).amount += holdingamount
			holdingblock := 0
			holdingamount := 0
		    else
			var tempid : int := inventory (i).id
			var tempamount : int := inventory (i).amount
			inventory (i).id := holdingblock
			inventory (i).amount := holdingamount
			holdingblock := tempid
			holdingamount := tempamount
		    end if
		    exit
		end if
	    end for
	    for i : 1 .. 3
		if x > maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 and y < maxy div 2 + 50 + 16 and x < maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 + 16 and y > maxy div 2
			+ 50 then
		    if craftingtable (1) (i).id = holdingblock then
			craftingtable (1) (i).amount += holdingamount
			holdingblock := 0
			holdingamount := 0
		    else
			var tempid : int := craftingtable (1) (i).id
			var tempamount : int := craftingtable (1) (i).amount
			craftingtable (1) (i).id := holdingblock
			craftingtable (1) (i).amount := holdingamount
			holdingblock := tempid
			holdingamount := tempamount
		    end if
		    exit
		end if
	    end for
	    for i : 1 .. 3
		if x > maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 and y < maxy div 2 + 32 + 16 and x < maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 + 16 and y > maxy div 2
			+ 32 then
		    if craftingtable (2) (i).id = holdingblock then
			craftingtable (2) (i).amount += holdingamount
			holdingblock := 0
			holdingamount := 0
		    else
			var tempid : int := craftingtable (2) (i).id
			var tempamount : int := craftingtable (2) (i).amount
			craftingtable (2) (i).id := holdingblock
			craftingtable (2) (i).amount := holdingamount
			holdingblock := tempid
			holdingamount := tempamount
		    end if
		    exit
		end if
	    end for
	    for i : 1 .. 3
		if x > maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 and y < maxy div 2 + 14 + 16 and x < maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 + 16 and y > maxy div 2
			+ 14
			then
		    if craftingtable (3) (i).id = holdingblock then
			craftingtable (3) (i).amount += holdingamount
			holdingblock := 0
			holdingamount := 0
		    else
			var tempid : int := craftingtable (3) (i).id
			var tempamount : int := craftingtable (3) (i).amount
			craftingtable (3) (i).id := holdingblock
			craftingtable (3) (i).amount := holdingamount
			holdingblock := tempid
			holdingamount := tempamount
		    end if
		    exit
		end if
	    end for
	end if
	leftheld := true
    end if
    %Right click interaction
    if button = 100 and rightheld = false then
	if x > maxx div 2 + 36 and x < maxx div 2 + 36 + 16 and y > maxy div 2 + 32 and y < maxy div 2 + 32 + 16 then
	    if output.id not= 0 and output.amount > 0 then
		if holdingblock = 0 or holdingblock = output.id then
		    crafttableupdate (craftingtable)
		    holdingblock := output.id
		    holdingamount += output.amount
		end if
	    end if
	end if
	if holdingblock = 0 then
	    for i : 1 .. 9
		if x > maxx div 2 - 176 div 2 + 6 + i * 16 + i * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + i * 16 + i * 2 - 16 + 16 and y > maxy div 2 - 166 div 2 +
			8 and y < maxy
			div 2
			- 166 div 2 + 8 + 16 then
		    if inventory (i).amount mod 2 = 0 then
			holdingblock := inventory (i).id
			holdingamount := inventory (i).amount div 2
			inventory (i).amount div= 2
		    else
			holdingblock := inventory (i).id
			holdingamount := ceil (inventory (i).amount / 2)
			inventory (i).amount := floor (inventory (i).amount / 2)
			if inventory (i).amount < 1 then
			    inventory (i).id := 0
			end if
		    end if
		    exit
		end if
	    end for
	    for i : 10 .. 18
		if x > maxx div 2 - 176 div 2 + 6 + (i - 9) * 16 + (i - 9) * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + (i - 9) * 16 + (i - 9) * 2 - 16 + 16 and y >
			maxy div 2 - 166
			div
			2 + 26 + 4 and y < maxy div 2
			- 166 div 2 + 26 + 16 + 4 then
		    if inventory (i).amount mod 2 = 0 then
			holdingblock := inventory (i).id
			holdingamount := inventory (i).amount div 2
			inventory (i).amount div= 2
		    else
			holdingblock := inventory (i).id
			holdingamount := ceil (inventory (i).amount / 2)
			inventory (i).amount := floor (inventory (i).amount / 2)
			if inventory (i).amount < 1 then
			    inventory (i).id := 0
			end if
		    end if
		    exit
		end if
	    end for
	    for i : 19 .. 27
		if x > maxx div 2 - 176 div 2 + 6 + (i - 18) * 16 + (i - 18) * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + (i - 18) * 16 + (i - 18) * 2 - 16 + 16 and y
			> maxy div 2 -
			166
			div 2 + 44 + 4 and y < maxy div 2
			- 166 div 2 + 44 + 16 + 4 then
		    if inventory (i).amount mod 2 = 0 then
			holdingblock := inventory (i).id
			holdingamount := inventory (i).amount div 2
			inventory (i).amount div= 2
		    else
			holdingblock := inventory (i).id
			holdingamount := ceil (inventory (i).amount / 2)
			inventory (i).amount := floor (inventory (i).amount / 2)
			if inventory (i).amount < 1 then
			    inventory (i).id := 0
			end if
		    end if
		    exit
		end if
	    end for
	    for i : 28 .. 36
		if x > maxx div 2 - 176 div 2 + 6 + (i - 27) * 16 + (i - 27) * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + (i - 27) * 16 + (i - 27) * 2 - 16 + 16 and y
			> maxy div 2 -
			166
			div 2 + 62 + 4 and y < maxy div 2
			- 166 div 2 + 62 + 16 + 4 then
		    if inventory (i).amount mod 2 = 0 then
			holdingblock := inventory (i).id
			holdingamount := inventory (i).amount div 2
			inventory (i).amount div= 2
		    else
			holdingblock := inventory (i).id
			holdingamount := ceil (inventory (i).amount / 2)
			inventory (i).amount := floor (inventory (i).amount / 2)
			if inventory (i).amount < 1 then
			    inventory (i).id := 0
			end if
		    end if
		    exit
		end if
	    end for
	    for i : 1 .. 3
		if x > maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 and y < maxy div 2 + 50 + 16 and x < maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 + 16 and y > maxy div 2
			+ 50 then
		    if craftingtable (1) (i).amount mod 2 = 0 then
			holdingblock := craftingtable (1) (i).id
			holdingamount := craftingtable (1) (i).amount div 2
			craftingtable (1) (i).amount div= 2
		    else
			holdingblock := craftingtable (1) (i).id
			holdingamount := ceil (craftingtable (1) (i).amount / 2)
			craftingtable (1) (i).amount := floor (craftingtable (1) (i).amount / 2)
			if craftingtable (1) (i).amount < 1 then
			    craftingtable (1) (i).id := 0
			end if
		    end if
		    exit
		end if
	    end for
	    for i : 1 .. 3
		if x > maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 and y < maxy div 2 + 32 + 16 and x < maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 + 16 and y > maxy div 2
			+ 32 then
		    if craftingtable (2) (i).amount mod 2 = 0 then
			holdingblock := craftingtable (2) (i).id
			holdingamount := craftingtable (2) (i).amount div 2
			craftingtable (2) (i).amount div= 2
		    else
			holdingblock := craftingtable (2) (i).id
			holdingamount := ceil (craftingtable (2) (i).amount / 2)
			craftingtable (2) (i).amount := floor (craftingtable (2) (i).amount / 2)
			if craftingtable (2) (i).amount < 1 then
			    craftingtable (2) (i).id := 0
			end if
		    end if
		    exit
		end if
	    end for
	    for i : 1 .. 3
		if x > maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 and y < maxy div 2 + 14 + 16 and x < maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 + 16 and y > maxy div 2
			+ 14
			then
		    if craftingtable (3) (i).amount mod 2 = 0 then
			holdingblock := craftingtable (3) (i).id
			holdingamount := craftingtable (3) (i).amount div 2
			craftingtable (3) (i).amount div= 2
		    else
			holdingblock := craftingtable (3) (i).id
			holdingamount := ceil (craftingtable (3) (i).amount / 2)
			craftingtable (3) (i).amount := floor (craftingtable (3) (i).amount / 2)
			if craftingtable (3) (i).amount < 1 then
			    craftingtable (3) (i).id := 0
			end if
		    end if
		    exit
		end if
	    end for
	else
	    for i : 1 .. 9
		if x > maxx div 2 - 176 div 2 + 6 + i * 16 + i * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + i * 16 + i * 2 - 16 + 16 and y > maxy div 2 - 166 div 2 +
			8 and y < maxy div 2
			- 166 div 2 + 8 + 16 then
		    if inventory (i).id = holdingblock then
			inventory (i).amount += 1
			holdingamount -= 1
		    elsif inventory (i).id = 0 then
			inventory (i).id := holdingblock
			inventory (i).amount := 1
			holdingamount -= 1
		    end if
		    if holdingamount = 0 then
			holdingblock := 0
		    end if
		    exit
		end if
	    end for
	    for i : 10 .. 18
		if x > maxx div 2 - 176 div 2 + 6 + (i - 9) * 16 + (i - 9) * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + (i - 9) * 16 + (i - 9) * 2 - 16 + 16 and y >
			maxy div 2 - 166 div
			2 + 26 + 4 and y < maxy div 2
			- 166 div 2 + 26 + 16 + 4 then
		    if inventory (i).id = holdingblock then
			inventory (i).amount += 1
			holdingamount -= 1
		    elsif inventory (i).id = 0 then
			inventory (i).id := holdingblock
			inventory (i).amount := 1
			holdingamount -= 1
		    end if
		    if holdingamount = 0 then
			holdingblock := 0
		    end if
		    exit
		end if
	    end for
	    for i : 19 .. 27
		if x > maxx div 2 - 176 div 2 + 6 + (i - 18) * 16 + (i - 18) * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + (i - 18) * 16 + (i - 18) * 2 - 16 + 16 and y
			> maxy div 2 - 166
			div 2 + 44 + 4 and y < maxy div 2
			- 166 div 2 + 44 + 16 + 4 then
		    if inventory (i).id = holdingblock then
			inventory (i).amount += 1
			holdingamount -= 1
		    elsif inventory (i).id = 0 then
			inventory (i).id := holdingblock
			inventory (i).amount := 1
			holdingamount -= 1
		    end if
		    if holdingamount = 0 then
			holdingblock := 0
		    end if
		    exit
		end if
	    end for
	    for i : 28 .. 36
		if x > maxx div 2 - 176 div 2 + 6 + (i - 27) * 16 + (i - 27) * 2 - 16 and x < maxx div 2 - 176 div 2 + 6 + (i - 27) * 16 + (i - 27) * 2 - 16 + 16 and y
			> maxy div 2 - 166
			div 2 + 62 + 4 and y < maxy div 2
			- 166 div 2 + 62 + 16 + 4 then
		    if inventory (i).id = holdingblock then
			inventory (i).amount += 1
			holdingamount -= 1
		    elsif inventory (i).id = 0 then
			inventory (i).id := holdingblock
			inventory (i).amount := 1
			holdingamount -= 1
		    end if
		    if holdingamount = 0 then
			holdingblock := 0
		    end if
		    exit
		end if
	    end for
	    for i : 1 .. 3
		if x > maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 and y < maxy div 2 + 50 + 16 and x < maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 + 16 and y > maxy div 2
			+ 50 then
		    if craftingtable (1) (i).id = holdingblock then
			craftingtable (1) (i).amount += 1
			holdingamount -= 1
		    elsif craftingtable (1) (i).id = 0 then
			craftingtable (1) (i).id := holdingblock
			craftingtable (1) (i).amount := 1
			holdingamount -= 1
		    end if
		    if holdingamount = 0 then
			holdingblock := 0
		    end if
		    exit
		end if
	    end for
	    for i : 1 .. 3
		if x > maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 and y < maxy div 2 + 32 + 16 and x < maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 + 16 and y > maxy div 2
			+ 32 then
		    if craftingtable (2) (i).id = holdingblock then
			craftingtable (2) (i).amount += 1
			holdingamount -= 1
		    elsif craftingtable (2) (i).id = 0 then
			craftingtable (2) (i).id := holdingblock
			craftingtable (2) (i).amount := 1
			holdingamount -= 1
		    end if
		    if holdingamount = 0 then
			holdingblock := 0
		    end if
		    exit
		end if
	    end for
	    for i : 1 .. 3
		if x > maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 and y < maxy div 2 + 14 + 16 and x < maxx div 2 - 58 + i * 16 + i * 2 - 16 - 2 + 16 and y > maxy div 2
			+ 14
			then
		    if craftingtable (3) (i).id = holdingblock then
			craftingtable (3) (i).amount += 1
			holdingamount -= 1
		    elsif craftingtable (3) (i).id = 0 then
			craftingtable (3) (i).id := holdingblock
			craftingtable (3) (i).amount := 1
			holdingamount -= 1
		    end if
		    if holdingamount = 0 then
			holdingblock := 0
		    end if
		    exit
		end if
	    end for
	end if
	rightheld := true
    end if
    %Button held variables
    if button = 100 then
	leftheld := false
    elsif button = 1 then
	rightheld := false
    else
	leftheld := false
	rightheld := false
    end if
    output := crafttable (craftingtable)
    %Exit crafting
    if chars (inventorykey) then
	Time.Delay (100)
	exit
    end if
    View.Update
    %cls
end loop
