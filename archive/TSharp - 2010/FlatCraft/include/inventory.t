Dir.Change (maindirectory)
%Resets variables
var holdingblock : int := 0
var holdingamount : int := 0
var holdingdurability : int := 0
var output : item
output.id := 0
output.amount := 0
var leftheld : boolean := false
var rightheld : boolean := false
Mouse.ButtonChoose ("multibutton")
Time.Delay (100)
loop
    %Draws background
    Pic.Draw (inventbackground, 0, 0, picCopy)
    %Gets input
    Input.KeyDown (chars)
    Mouse.Where (mx, my, mbutton)
    %Draws screen
    Pic.Draw (inventoryscreen, maxx div 2 - 176 div 2, maxy div 2 - 166 div 2, picCopy)
    var height, ascent, descent, internalLeading : int
    var font : int := Font.New ("Impact:8")
    Font.Sizes (font, height, ascent, descent, internalLeading)
    %Loops through each row of inventory items, and column
    for row : 1 .. 4
	for decreasing itemx : 9 .. 1
	    %Re-assigns the i value to be the inventory slot allocated to the slot being assessed.
	    var i : int := row * 9 - 9 + itemx
	    %Y position of bottom of the slot
	    var yadj : int := 0
	    %First row is special as there is a larger gap between it and the next
	    if row = 1 then
		yadj := 8
	    else
		yadj := 18 * (row - 1) + 12
	    end if
	    %Draws the item and amount label
	    if inventory (i).id not= 0 then
		Pic.Draw (textures (inventory (i).id) (0), maxx div 2 - 176 div 2 + 6 + itemx * 16 + itemx * 2 - 16, maxy div 2 - 166 div 2 + yadj, picMerge)
		Font.Draw (intstr (inventory (i).amount), maxx div 2 - 176 div 2 + 6 + itemx * 16 + itemx * 2 - 16 + 1, maxy div 2 - 166 div 2 + yadj + 1, font, white)
	    end if
	    %IF the item is being hovered over
	    if mx > maxx div 2 - 176 div 2 + 6 + itemx * 16 + itemx * 2 - 16 and mx < maxx div 2 - 176 div 2 + 6 + itemx * 16 + itemx * 2 - 16 + 16 and
		    my > maxy div 2 - 166 div 2 + yadj and my < maxy div 2 - 166 div 2 + yadj + 16 then
		%Draws name label
		var width := Font.Width (blockinfos (inventory (i).id).name, font)
		if blockinfos (inventory (i).id).name not= "" then
		    Draw.FillBox (mx + 7, my - 8, mx + 8 + width, my - 6 + ascent - descent, black)
		end if
		Font.Draw (blockinfos (inventory (i).id).name, mx + 8, my - 7, font, white)
		%If there isnt a block being held
		if holdingblock = 0 then
		    %If the player clicks the left mouse button
		    if mbutton = 1 and leftheld = false then
			%Swaps the contents of the inventory slot into the holding item
			holdingblock := inventory (i).id
			holdingamount := inventory (i).amount
			holdingdurability := inventory (i).durability
			inventory (i).id := 0
			inventory (i).amount := 0
			inventory (i).durability := 0
			%If the player clicks the right mouse
		    elsif mbutton = 100 and rightheld = false then
			%Divides the inventory slot into 2 parts, one int the same inventory slot, and the other in the holding item
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
		    end if
		    %If there is a block being held
		else
		    %If the left mouse is pressed
		    if mbutton = 1 and leftheld = false then
			%If the inventory item is the same as the holding item, it adds the holding item to the inventory item, otherwise, it swaps them
			if inventory (i).id = holdingblock then
			    inventory (i).amount += holdingamount
			    holdingblock := 0
			    holdingamount := 0
			else
			    var tempid : int := inventory (i).id
			    var tempamount : int := inventory (i).amount
			    var tempdurability : int := inventory (i).durability
			    inventory (i).id := holdingblock
			    inventory (i).amount := holdingamount
			    inventory (i).durability := holdingdurability
			    holdingblock := tempid
			    holdingamount := tempamount
			    holdingdurability := tempdurability
			end if
			%If the right mouse is pressed
		    elsif mbutton = 100 and rightheld = false then
			%Adds 1 from the holding item to the inventory
			if inventory (i).id = holdingblock then
			    inventory (i).amount += 1
			    holdingamount -= 1
			elsif inventory (i).id = 0 then
			    inventory (i).id := holdingblock
			    inventory (i).amount := 1
			    holdingamount -= 1
			end if
			if holdingamount <= 0 then
			    holdingblock := 0
			end if
		    end if
		end if
	    end if
	end for
    end for
    %Loops through the slots in the table, the majority of this is very similar to the above, so look there for reference.
    for tabley : 1 .. 2
	for tablex : 1 .. 2
	    var yadj : int := 0
	    if tabley = 1 then
		yadj := 41
	    else
		yadj := 23
	    end if
	    if table (tabley) (tablex).id not= 0 then
		Pic.Draw (textures (table (tabley) (tablex).id) (0), maxx div 2 + tablex * 16 + tablex * 2 - 16 - 2, maxy div 2 + yadj, picMerge)
		Font.Draw (intstr (table (tabley) (tablex).amount), maxx div 2 + tablex * 16 + tablex * 2 - 16 - 1, maxy div 2 + yadj + 1, font, white)
	    end if
	    if mx > maxx div 2 + tablex * 16 + tablex * 2 - 16 - 2 and my < maxy div 2 + yadj + 16 and mx < maxx div 2 + tablex * 16 + tablex * 2 - 16 - 2 + 16 and my > maxy div 2 + yadj then
		var width := Font.Width (blockinfos (table (tabley) (tablex).id).name, font)
		if blockinfos (table (tabley) (tablex).id).name not= "" then
		    Draw.FillBox (mx + 7, my - 8, mx + 8 + width, my - 6 + ascent - descent, black)
		end if
		Font.Draw (blockinfos (table (tabley) (tablex).id).name, mx + 8, my - 7, font, white)
		if holdingblock = 0 then
		    if mbutton = 1 and leftheld = false then
			holdingblock := table (tabley) (tablex).id
			holdingamount := table (tabley) (tablex).amount
			holdingdurability := table (tabley) (tablex).durability
			table (tabley) (tablex).id := 0
			table (tabley) (tablex).amount := 0
			table (tabley) (tablex).durability := 0
		    elsif mbutton = 100 and rightheld = false then
			if table (tabley) (tablex).amount mod 2 = 0 then
			    holdingblock := table (tabley) (tablex).id
			    holdingamount := table (tabley) (tablex).amount div 2
			    table (tabley) (tablex).amount div= 2
			else
			    holdingblock := table (tabley) (tablex).id
			    holdingamount := ceil (table (tabley) (tablex).amount / 2)
			    table (tabley) (tablex).amount := floor (table (tabley) (tablex).amount / 2)
			    if table (tabley) (tablex).amount < 1 then
				table (tabley) (tablex).id := 0
			    end if
			end if
		    end if
		else
		    if mbutton = 1 and leftheld = false then
			if table (tabley) (tablex).id = holdingblock then
			    table (tabley) (tablex).amount += holdingamount
			    holdingblock := 0
			    holdingamount := 0
			else
			    var tempid : int := table (tabley) (tablex).id
			    var tempamount : int := table (tabley) (tablex).amount
			    var tempdurability : int := table (tabley) (tablex).durability
			    table (tabley) (tablex).id := holdingblock
			    table (tabley) (tablex).amount := holdingamount
			    table (tabley) (tablex).durability := holdingdurability
			    holdingblock := tempid
			    holdingamount := tempamount
			    holdingdurability := tempdurability
			end if
		    elsif mbutton = 100 and rightheld = false then
			if table (tabley) (tablex).id = holdingblock then
			    table (tabley) (tablex).amount += 1
			    holdingamount -= 1
			elsif table (tabley) (tablex).id = 0 then
			    table (tabley) (tablex).id := holdingblock
			    table (tabley) (tablex).amount := 1
			    holdingamount -= 1
			end if
			if holdingamount <= 0 then
			    holdingblock := 0
			end if
		    end if
		end if
	    end if
	end for
    end for
    %Draws the output item and amount
    if output.id not= 0 and output.amount not= 0 then
	Pic.Draw (textures (output.id) (0), maxx div 2 + 56, maxy div 2 + 31, picMerge)
	Font.Draw (intstr (output.amount), maxx div 2 + 57, maxy div 2 + 32, font, white)
    end if
    %If the mouse is hovering the output item
    if mx > maxx div 2 + 56 and mx < maxx div 2 + 56 + 16 and my > maxy div 2 + 31 and my < maxy div 2 + 31 + 16 then
	%Draws the label
	var width := Font.Width (blockinfos (output.id).name, font)
	if blockinfos (output.id).name not= "" then
	    Draw.FillBox (mx + 7, my - 8, mx + 8 + width, my - 6 + ascent - descent, black)
	end if
	Font.Draw (blockinfos (output.id).name, mx + 8, my - 7, font, white)
	%If clicked, it adds the output item to the holdig item.
	if (mbutton = 1 and leftheld = false) or (mbutton = 100 and rightheld = false) then
	    if output.id not= 0 and output.amount > 0 then
		if holdingblock = 0 or holdingblock = output.id then
		    inventtableupdate (table)
		    holdingblock := output.id
		    holdingamount += output.amount
		end if
	    end if
	end if
    end if
    %Draws the holding item
    if holdingblock not= 0 then
	Pic.Draw (textures (holdingblock) (0), mx - 8, my - 8, picMerge)
	var width := Font.Width (blockinfos (holdingblock).name, font)
	Draw.FillBox (mx + 7, my - 8, mx + 8 + width, my - 6 + ascent - descent, black)
	Font.Draw (intstr (holdingamount), mx - 7, my - 7, font, white)
	Font.Draw (blockinfos (holdingblock).name, mx + 8, my - 7, font, white)
    end if
    %Holding variables, prevents flickering when clicking
    if mbutton = 100 then
	rightheld := true
	leftheld := false
    elsif mbutton = 1 then
	leftheld := true
	rightheld := false
    else
	leftheld := false
	rightheld := false
    end if
    %Checks for crafting matches
    output := inventtable (table)
    %Exit invent
    if chars (inventorykey) then
	Time.Delay (100)
	exit
    end if
    View.Update
end loop
