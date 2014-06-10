
% Generates a random seed to be used if a new map is generated, this will be reassigned if loading a map
seed := Rand.Int (-1073741824, 1073741824)
%Resets the time counter
ingametime := 0
% Resets the players x position
positionx := 0
% Specifies the actual chunk index of the first chunk in the "chunks" array
base := -5
% Resets the players y position
positiony := 64 * 16
% Resets the inventory to default
for i : 1 .. 36
    inventory (i).id := 0
    inventory (i).amount := 0
end for
% Resets the players health
playerhealth := 20
for i : 1 .. 1000
    blockentities (i).id := 0
    blockentities (i).amount := 0
    blockentities (i).durability := 0
    blockentities (i).x := 0
    blockentities (i).y := 0
end for
% Creates the array to hold the map names in the saves folder
var mapnames : flexible array 1 .. 0 of string
% Opens the saves directory and assigns all folder names to a new index in the mapnames array
var streamNumber : int
var fileName : string
Dir.Change (maindirectory)
if Dir.Exists (Dir.Current + "/saves") = false then
    Dir.Create ("saves")
end if
Dir.Change (Dir.Current + "/saves")
streamNumber := Dir.Open (Dir.Current)
loop
    var temp2 := Dir.Get (streamNumber)
    var length2 : int := 4
    if length (temp2) < 4 then
	length2 := length (temp2)
    end if
    if temp2 (1 .. length2) not= "null" then
	new mapnames, upper (mapnames) + 1
	mapnames (upper (mapnames)) := temp2
	exit when mapnames (upper (mapnames)) = ""
    end if
end loop
% Closes the directory to prevent errors
Dir.Close (streamNumber)
% Creates the variable that tells which menu screen we are on, it is defaulted to 1 as this is the main menu screen
var screen : int := 1
% These variables hold user input
var x, y, button : int
var chars : array char of boolean
% This string is re-used alot so we create it one time here and use it in its various locations
var back : string := "Back"
var message : string := menumessages (Rand.Int (1, upper (menumessages)))
var buttonheld : boolean := false
var deletebutton : int := Pic.FileNew ("../images/delete.gif")
var titlewidth : int
loop
    % Checks to make sure that the user is not supposed to be playing the game
    if playing = false then
	% Gets the location of the mouse
	Mouse.Where (x, y, button)
	% Draws the background image
	Pic.Draw (MenuBG, 0, 0, picCopy)
	% Creates a font and draws the title
	var font := Font.New ("Impact:48")
	var height, ascent, descent, internalLeading : int
	Font.Sizes (font, height, ascent, descent, internalLeading)
	var Title : string := "2D-Craft"
	var width := Font.Width (Title, font)
	titlewidth := width
	Font.Draw (Title, round (maxx / 2 - width / 2), 541, font, black)
	% Re-assigns the font to a different size to draw the credit text in the bottom right corner
	font := Font.New ("Impact:12")
	Font.Sizes (font, height, ascent, descent, internalLeading)
	var credit : string := "Created by: Jonathan Sells"
	width := Font.Width (credit, font)
	Font.Draw (credit, round (maxx - width - 5), 5, font, black)
	width := Font.Width (message, font)
	Font.Draw (message, round (maxx / 2 + titlewidth / 2) - width, 521, font, yellow)
	% Checks which menu the user is in
	if screen = 1 then
	    % For the main menu it creates a font to draw the "Play Game" button
	    font := Font.New ("Impact:28")
	    Font.Sizes (font, height, ascent, descent, internalLeading)
	    var worldSelect : string := "Play Game"
	    width := Font.Width (worldSelect, font)
	    Font.Draw (worldSelect, round (maxx / 2 - width / 2), 341, font, black)
	    % Checks to see if the user has clicked the button
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 341 and y < 341 + ascent - descent and button = 1 and buttonheld = false then
		% If so it navigates to the Level selection menu
		screen := 2
	    end if
	    % Creates a new font for the "Options" option
	    font := Font.New ("Impact:22")
	    Font.Sizes (font, height, ascent, descent, internalLeading)
	    var options : string := "Options"
	    width := Font.Width (options, font)
	    Font.Draw (options, round (maxx / 2 - width / 2), 291, font, black)
	    % Checks if the user has clicked the button
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 291 and y < 291 + ascent - descent and button = 1 and buttonheld = false then
		% Sets the screen to the "Options" screen
		screen := 3
	    end if
	    % Creates a font to draw the "Quit" button
	    font := Font.New ("Impact:22")
	    Font.Sizes (font, height, ascent, descent, internalLeading)
	    var quitGame : string := "Quit"
	    width := Font.Width (quitGame, font)
	    Font.Draw (quitGame, round (maxx / 2 - width / 2), 251, font, black)
	    % Checks to see if the use has clicked the button
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 251 and y < 251 + ascent - descent and button = 1 and buttonheld = false then
		quitbool := true
		exit
	    end if
	    % Checks if the user is in the "Level Selection" screen
	elsif screen = 2 then
	    % Creates the font that will be used to display each map name
	    font := Font.New ("Impact:22")
	    Font.Sizes (font, height, ascent, descent, internalLeading)
	    % Repeats for every existing map. The first 2 and last one are skipped as the first 2 are a . and a .. representing the current folder
	    % and the parent folder and the last name is blank as there were no more folders left when it was being loaded
	    for i : 3 .. upper (mapnames) - 1
		% Draws each individual name
		width := Font.Width (mapnames (i), font)
		%Draws delete button
		Pic.Draw (deletebutton, round (maxx / 2 + width / 2) + 6, 381 - i * 40 + 82, picMerge)
		%Draws Name
		Font.Draw (mapnames (i), round (maxx / 2 - width / 2), 381 - i * 40 + 80, font, black)
		% Checks if the user has clicked the mapname
		if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 381 - i * 40 + 80 and y < 381 - 1 * 40 + 80 + ascent - descent and button = 1 and buttonheld = false then
		    % Sets the mapname to the one that was clicked and sets playing = to true so the menu screens close
		    mapname := mapnames (i)
		    playing := true
		    exit
		    %If the user has clicked delete
		elsif x > round (maxx / 2 + width / 2) + 6 and x < round (maxx / 2 + width / 2) + 21 and
			y > 381 - i * 40 + 82 and y < 381 - i * 40 + 97 and button = 1 and buttonheld = false then
		    %Call the delete folder procedure and resize the mapnames array
		    Dir.Change (maindirectory)
		    Dir.Change ("saves")
		    deletefolder (Dir.Current + "/" + mapnames (i))
		    Dir.Change (maindirectory)
		    for count : i .. upper (mapnames) - 1
			mapnames (count) := mapnames (count + 1)
		    end for
		    new mapnames, upper (mapnames) - 1
		end if
	    end for
	    % Draws the text for creating a new level
	    var createmap : string := "New Game"
	    width := Font.Width (createmap, font)
	    Font.Draw (createmap, round (maxx / 2 - width / 2), 381 - upper (mapnames) * 40 + 80, font, black)
	    width := Font.Width (back, font)
	    Font.Draw (back, round (maxx / 2 - width / 2), 381 - upper (mapnames) * 40 + 80 - 100, font, black)
	    % Checks if the user has clicked the button
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 381 - upper (mapnames) * 40 + 80 - 100 and y < 381 - upper (mapnames) * 40 + 80 - 100 + ascent - descent and button =
		    1 and buttonheld = false
		    then
		% Sets the screen to the main menu
		screen := 1
	    end if
	    % Checks if the user has clicked the button
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 381 - upper (mapnames) * 40 + 80 and y < 381 - upper (mapnames) * 40 + 80 + ascent - descent and button = 1 and
		    buttonheld = false then
		% Takes off offscreenonly so the user can see what he/she is typing and the cursor
		setscreen ("nooffscreenonly")
		% Creates a text field and a "Create Map" button, when the button is clicked it calls the procedure to create a new map
		var nameTextField := GUI.CreateTextField (350, 381 - upper (mapnames) * 40 + 40, 100, "New Map", mapNameEntered)
		var createthemap : int := GUI.CreateButton (350, 381 - upper (mapnames) * 40 + 10, 100, "Create Map", createMap)
		% Continually loops until the user clicks the "Create Map" button
		loop
		    % Gets the users mouse position
		    Mouse.Where (x, y, button)
		    % Draws the back button
		    width := Font.Width (back, font)
		    Font.Draw (back, round (maxx / 2 - width / 2), 381 - upper (mapnames) * 40 + 80 - 100, font, black)
		    % Checks if the user has clicked the back button
		    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 381 - upper (mapnames) * 40 + 80 - 100 and y < 381 - upper (mapnames) * 40 + 80 - 100 + ascent - descent and
			    button = 1 and buttonheld = false then
			% Sets the screen to the main menu
			screen := 1
		    end if
		    exit when GUI.ProcessEvent or screen = 1
		end loop
		GUI.ResetQuit
		% Turns offscreenonly back on to prevent any flickering
		setscreen ("offscreenonly")
		% Sets the mapname to the mapname that was entered
		mapname := GUI.GetText (nameTextField)
		GUI.Dispose (nameTextField)
		GUI.Dispose (createthemap)
		% Exits the menus if the mapname was entered
		if playing = true then
		    exit
		end if
	    end if
	elsif screen = 3 then
	    % Removes the curor as it would otherwise show in the top left corner when the user goes to enter a character
	    setscreen ("nocursor")
	    % Creates the font
	    font := Font.New ("Impact:22")
	    Font.Sizes (font, height, ascent, descent, internalLeading)
	    % Creates the strings for each option, We use the \ to escape the quotation mark so we can surround the keyvalue in quotes
	    var leftkeytext : string := "Left: \"" + leftkey + "\""
	    var rightkeytext : string := "Right: \"" + rightkey + "\""
	    var jumpkeytext : string := "Jump: \"" + jumpkey + "\""
	    width := Font.Width (leftkeytext, font)
	    % Draws the left key
	    Font.Draw (leftkeytext, round (maxx / 2 - width / 2), 421, font, black)
	    % If the user clicked the left key text button thingy
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 421 and y < 421 + ascent - descent and button = 1 and buttonheld = false then
		% Assigns the leftkey variable to be the character the user enters
		leftkey := getchar
		% Redirects to the main directory to allow for proper saving
		Dir.Change (maindirectory)
		% Saves the key configuration
		open : stream, "datafiles/controls", put
		put : stream, leftkey
		put : stream, rightkey
		put : stream, jumpkey
		% Closes file to prevent errors
		close : stream
	    end if
	    width := Font.Width (rightkeytext, font)
	    % Draws the right key text button thingy
	    Font.Draw (rightkeytext, round (maxx / 2 - width / 2), 381, font, black)
	    % Checks if the user clicked the right key text button thingy
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 381 and y < 381 + ascent - descent and button = 1 and buttonheld = false then
		% Assigns the rightkey variable to the inputted character
		rightkey := getchar
		% Redirects to the main directory to prevent saving in wrong place
		Dir.Change (maindirectory)
		% Saves the key configurations
		open : stream, "datafiles/controls", put
		put : stream, leftkey
		put : stream, rightkey
		put : stream, jumpkey
		% Closes file to prevent errors
		close : stream
	    end if
	    width := Font.Width (jumpkeytext, font)
	    % Draws the jump key text button thingy
	    Font.Draw (jumpkeytext, round (maxx / 2 - width / 2), 341, font, black)
	    % Checks if the user clicked the jump key text button thingy
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 341 and y < 341 + ascent - descent and button = 1 and buttonheld = false then
		% Assigns the jumpkey variable to the inputted character
		jumpkey := getchar
		% Redirects to the main directory to prevent saving in wrong place
		Dir.Change (maindirectory)
		% Saves the key configurations
		open : stream, "datafiles/controls", put
		put : stream, leftkey
		put : stream, rightkey
		put : stream, jumpkey
		% Closes file to prevent errors
		close : stream
	    end if
	    %Dras the playerdrawing option
	    var PlayerDrawingText : string := ""
	    if playerdrawing = true then
		PlayerDrawingText := "Draw Player Model: Yes"
	    else
		PlayerDrawingText := "Draw Player Model: No"
	    end if
	    width := Font.Width (PlayerDrawingText, font)
	    % Draws the playerdrawing button
	    Font.Draw (PlayerDrawingText, round (maxx / 2 - width / 2), 301, font, black)
	    % Checks if the user clicked the playerdrawing button
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 301 and y < 301 + ascent - descent and button = 1 and buttonheld = false then
		%Switches the states
		if playerdrawing = true then
		    playerdrawing := false
		else
		    playerdrawing := true
		end if
	    end if
	    width := Font.Width (back, font)
	    % Draws the back button
	    Font.Draw (back, round (maxx / 2 - width / 2), 261, font, black)
	    % If the back button is clicked
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 261 and y < 261 + ascent - descent and button = 1 and buttonheld = false then
		% Redirect to the main menu
		screen := 1
	    end if
	    % Re-enable cursor for map creation dialog boxes
	    setscreen ("cursor")
	end if
	% Only updates the screen if the menu will be re-opened
	if playing = false then
	    View.Update
	end if
	% If the user is not supposed to be in the menus we exit the menu loop
    else
	exit
    end if
    if button = 0 then
	buttonheld := false
    else
	buttonheld := true
    end if
end loop
