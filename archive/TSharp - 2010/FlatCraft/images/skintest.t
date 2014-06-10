var window : int := Window.Open ("graphics: 800, 640, offscreenonly")
var blocknum : int := 19
var blocksimage : int := Pic.FileNew ("modifiedterrain.bmp")
var blocks : flexible array 1 .. 1 of int
var items : array 1 .. 16 of array 1 .. 16 of int
Pic.Draw (blocksimage, 0, 0, picMerge)
for i : 1 .. 14
    blocks (upper (blocks)) := Pic.New (180, i * 16 - 16, 191, i * 16 - 1)
    new blocks, upper (blocks) + 1
end for
var amountofitems : int := 25
var numblocks : int := upper (blocks) - 1
for i : 1 .. 12
    for j : 1 .. 2
	if j * 12 - 12 + i <= amountofitems then
	    blocks (upper (blocks)) := Pic.New (i * 16 - 16, numblocks * 16 + j * 16 - 16, i * 16 - 1, numblocks * 16 + j * 16 - 1)
	    blocks (upper (blocks)) := Pic.Mirror (blocks (upper (blocks)))
	    new blocks, upper (blocks) + 1
	end if
    end for
end for
cls
var playerskin : int := Pic.FileNew ("char.gif")
Pic.Draw (playerskin, 0, 0, picMerge)
%Creates base images
var rightleg : int := Pic.New (0, 0, 3, 11)
var leftleg : int := Pic.New (8, 0, 11, 11)
var rightarm : int := Pic.New (40, 0, 43, 11)
var leftarm : int := Pic.New (48, 0, 51, 11)
var rightbody : int := Pic.New (16, 0, 19, 11)
var leftbody : int := Pic.New (28, 0, 31, 11)
var righthead : int := Pic.New (0, 16, 7, 23)
var lefthead : int := Pic.New (16, 16, 23, 23)
cls
% Recreates the moving parts, but with whitespace around them to allow for easier rotation.
Pic.Draw (rightarm, 50, 50, picMerge)
Pic.Free (rightarm)
rightarm := Pic.New (37, 45, 66, 76)
cls
Pic.Draw (leftarm, 50, 50, picMerge)
Pic.Free (leftarm)
leftarm := Pic.New (37, 45, 66, 76)
cls
Pic.Draw (rightleg, 50, 50, picMerge)
Pic.Free (rightleg)
rightleg := Pic.New (37, 45, 66, 76)
cls
Pic.Draw (leftleg, 50, 50, picMerge)
Pic.Free (leftleg)
leftleg := Pic.New (37, 45, 66, 76)
cls
Pic.Draw (righthead, 50, 50, picMerge)
Pic.Free (righthead)
righthead := Pic.New (42, 38, 57, 66)
cls
Pic.Draw (lefthead, 50, 50, picMerge)
Pic.Free (lefthead)
lefthead := Pic.New (42, 38, 57, 66)
cls
%Middley and armpivot are variables used for calculations by non-leg moving parts (Head, Arm) so I made an original and re-assign them every loop according to the leg movement(Bobbing)
%The mods are the variables that hold the images for the rotated body parts
%Facing direction is which half of the screen the mouse is on
%Moving Direction is the direction in which the character is moving, this is used for constant movement in the demo,
%Leg Pivot X is the x position in which the leg is being held in place and rotating around
%MaxLegAngle is the maximum angle in degrees that the legs can move befor taking another step
var mx, my, mbutton : int
var middlex : int := round (maxx / 2)
var middleyorig : int := round (maxy / 2)
var middley : int := middleyorig
var armheadpivotyorig : int := middley + 24
var armheadpivoty : int := armheadpivotyorig
var armangle : real
var rightarmmod : int
var leftarmmod : int
var rightheadmod : int
var leftheadmod : int
var rightlegmod : int
var leftlegmod : int
var facingdirection : int := 1
var playerx : int := 0
var movingdirection : int := 0
var legpivotx : int := 0
const maxlegangle : int := 45
var timecntr : int := 0
var chars : array char of boolean
var lastarmpos : real := 90
var lastarmswing : string := "right"
var armswing : string := "right"
var armswingchange := false
loop

    Input.KeyDown (chars)
    if chars ('d') then
	playerx += 1
	movingdirection := 1
    end if
    if chars ('a') then
	playerx -= 1
	movingdirection := 0
    end if
    /*
     % Increments the players position
     if movingdirection = 1 then
     playerx += 1
     else
     playerx -= 1
     end if
     */
    %The ArcCos of the distance from pivot divided by the length of the legs  gives the angle of the leg from the ground
    var legangle : real := arccosd ((playerx - legpivotx) / 12)
    % The angle needs to be modified slightly for leftwards movement
    if movingdirection not= 1 then
	legangle := 180 - legangle
    end if
    put "Leg angle: ", legangle
    % If the target leg movement range has been reached then change the pivot point to the position in which the previously moving leg lands
    if legangle < 45 then
	if armswingchange = false then
	    legpivotx := legpivotx + ((playerx - legpivotx) * 2)
	    if armswing = "right" then
		armswing := "left"
	    else
		armswing := "right"
	    end if
	end if
	legangle := 45
	armswingchange := true
    else
	armswingchange := false
    end if
    %using the sine law we can crossmultiply and get an equation of LegLength*sin(Legangle) = x(sin90)
    %Since sin90 is equal to 1 we can simplify the equation to x = LegLength*sin(LegAngle)
    %This gives us the distance from the ground to the top of the leg
    var x : real := 12 * sind (legangle)
    put "Body Offset(12 when standing): ", x
    % Draws right side of the leg is facing the right, left if facing the left
    if facingdirection = 1 then
	%Creates a rotated image of the leg
	rightlegmod := Pic.Rotate (rightleg, round (legangle) - 90, 15, 15)
	% Drwas the leg
	Pic.Draw (rightlegmod, middlex - 15, middleyorig - 5, picMerge)
	% Frees the image to prevent overflow
	Pic.Free (rightlegmod)
	%Creates a rotated image of the other leg
	rightlegmod := Pic.Rotate (rightleg, -round (legangle) + 90, 15, 15)
	%Draws the second leg
	Pic.Draw (rightlegmod, middlex - 15, middleyorig - 5, picMerge)
	%Frees the image to prevent overflow
	Pic.Free (rightlegmod)
    else
	leftlegmod := Pic.Rotate (leftleg, round (legangle) - 90, 15, 15)
	Pic.Draw (leftlegmod, middlex - 15, middleyorig - 5, picMerge)
	Pic.Free (leftlegmod)
	leftlegmod := Pic.Rotate (leftleg, -round (legangle) + 90, 15, 15)
	Pic.Draw (leftlegmod, middlex - 15, middleyorig - 5, picMerge)
	Pic.Free (leftlegmod)
    end if
    % Reassigns the calculation variables for use with the arm/head
    armheadpivoty := round (armheadpivotyorig - (12 - x))
    middley := round (middleyorig - (12 - x))
    %Draws the ground
    for i : 1 .. maxx
	Draw.FillBox (i, 0, i + 1, middleyorig, (playerx + i) mod 256)
    end for
    %Gets the mouse position
    Mouse.Where (mx, my, mbutton)
    %If the mouse is not on  a border of one of the 4 quadrants
    if mx - middlex not= 0 and my - armheadpivoty not= 0 then
	%Use tangent of an imaginary triangle from the pivot point
	armangle := arctand ((mx - middlex) / (my - armheadpivoty))
	%Otherwise assign it solid values according to the border the mouse is on
    elsif mx - middlex = 0 and my - armheadpivoty > 0 then
	armangle := 90
    elsif mx - middlex = 0 and my - armheadpivoty < 0 then
	armangle := 270
    elsif mx - middlex > 0 and my - armheadpivoty = 0 then
	armangle := 0
    elsif mx - middlex < 0 and my - armheadpivoty = 0 then
	armangle := 180
    end if
    % If the mouse is not on a quadrant border then modify the angle according to the side of the screen its on (top/bottom)
    if my >= armheadpivoty and mx - middlex not= 0 and my - armheadpivoty not= 0 then
	armangle := 90 - armangle
    elsif my <= armheadpivoty and mx - middlex not= 0 and my - armheadpivoty not= 0 then
	armangle := 270 - armangle
    end if
    %If the mouse is on the left half of the screen the player is facing left
    if armangle > 90 and armangle < 270 then
	facingdirection := 0
    else
	%Otherwise the player is facing right
	facingdirection := 1
    end if
    put "Arm Angle: ", armangle
    % Draws the body parts according to which side is visible
    if facingdirection = 1 then
	%Draws the body at the same spot every time
	Pic.Draw (rightbody, middlex - 2, middley + 12, picMerge)
	% Creates a rotation of the head and arm according to the angle they both face, then draws it and frees it from memory
	rightheadmod := Pic.Rotate (righthead, round (armangle), 12, 12)
	Pic.Draw (rightheadmod, middlex - 12, middley + 12, picMerge)
	Pic.Free (rightheadmod)
	rightarmmod := Pic.Rotate (rightarm, round (armangle) + 90, 15, 15)
	Pic.Draw (rightarmmod, middlex - 15, middley + 7, picMerge)
	Pic.Free (rightarmmod)
	if lastarmswing = "right" then
	    rightarmmod := Pic.Rotate (rightarm, -round (legangle) + 90, 15, 15)
	    lastarmpos := -round (legangle) + 90
	else
	    rightarmmod := Pic.Rotate (rightarm, round (legangle) - 90, 15, 15)
	    lastarmpos := round (legangle) - 90
	end if
	lastarmswing := armswing
	Pic.Draw (rightarmmod, middlex - 15, middley + 7, picMerge)
	Pic.Free (rightarmmod)
	var handitem : int
	if blocknum > numblocks then
	    handitem := Pic.Rotate (blocks (blocknum), round (armangle) - 45, 12, 4)
	else
	    handitem := Pic.Rotate (blocks (blocknum), round (armangle), 4, 4)
	end if
	var handx, handy : int
	handx := round (11 * sind (90 - armangle))
	put handx
	handy := round (11 * sind (armangle))
	put handy
	if blocknum > numblocks then
	    Pic.Draw (handitem, middlex + handx - 12, middley + 22 + handy - 4, picMerge)
	else
	    Pic.Draw (handitem, middlex + handx - 4, middley + 22 + handy - 4, picMerge)
	end if
	Pic.Free (handitem)
    else
	Pic.Draw (leftbody, middlex - 2, middley + 12, picMerge)
	leftheadmod := Pic.Rotate (lefthead, round (armangle) - 180, 12, 12)
	Pic.Draw (leftheadmod, middlex - 12, middley + 12, picMerge)
	Pic.Free (leftheadmod)
	leftarmmod := Pic.Rotate (leftarm, round (armangle) + 90, 15, 15)
	Pic.Draw (leftarmmod, middlex - 15, middley + 7, picMerge)
	Pic.Free (leftarmmod)
	if lastarmswing = "right" then
	    leftarmmod := Pic.Rotate (leftarm, -round (legangle) + 90, 15, 15)
	    lastarmpos := -round (legangle) + 90
	else
	    leftarmmod := Pic.Rotate (leftarm, round (legangle) - 90, 15, 15)
	    lastarmpos := round (legangle) - 90
	end if
	lastarmswing := armswing
	Pic.Draw (leftarmmod, middlex - 15, middley + 7, picMerge)
	Pic.Free (leftarmmod)
	var handitem : int
	if blocknum > numblocks then
	    handitem := Pic.Rotate (blocks (blocknum), round (armangle) + 135, 12, 4)
	else
	    handitem := Pic.Rotate (blocks (blocknum), round (armangle), 4, 4)
	end if
	var handx, handy : int
	handx := round (10 * sind (90 - armangle))
	put handx
	handy := round (10 * sind (armangle))
	put handy
	if blocknum > numblocks then
	    Pic.Draw (handitem, middlex + handx - 12, middley + 22 + handy - 4, picMerge)
	else
	    Pic.Draw (handitem, middlex + handx - 4, middley + 22 + handy - 4, picMerge)
	end if
	Pic.Free (handitem)
    end if
    put 1000 / (Time.Elapsed - timecntr)
    timecntr := Time.Elapsed
    %Smooths the animation
    View.Update
    cls
    %This creates a movement speed equal to that of my game (32 pixels per second), this way the animation is the same speed as it will be in when implemented

    Time.DelaySinceLast (31)
end loop

