playing := false
% Resets the screen to the main pause screen
screen := 11
loop
    % Checks to make sure that the user is not supposed to be playing the game
    if playing = false then
	% Gets the location of the mouse
	Mouse.Where (x, y, button)
	% Draws the background image
	Pic.Draw (MenuBG, 0, 0, picCopy)
	% Creates the font for the pause menu title
	var font := Font.New ("Impact:36")
	var height, ascent, descent, internalLeading : int
	Font.Sizes (font, height, ascent, descent, internalLeading)
	% The string for the pause menu text
	var pausemenu : string := "Pause Menu"
	var width := Font.Width (pausemenu, font)
	% Draws the pause menu title
	Font.Draw (pausemenu, round (maxx / 2 - width / 2), 541, font, black)
	% If the user is in the main pause screen
	if screen = 11 then
	    % Creates the font for the options
	    font := Font.New ("Impact:26")
	    % The text for the "Return to game" option
	    var returnToGame : string := "Return To Game"
	    width := Font.Width (returnToGame, font)
	    % Draws the "Return to game" option
	    Font.Draw (returnToGame, round (maxx / 2 - width / 2), 471, font, black)
	    % Checks if the user has clicked the "Return to game" option
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 471 and y < 471 + ascent - descent and button = 1 and buttonheld = false then
		% Sets playing to true as the user is now supposed to be ingame again
		playing := true
	    end if
	    % The string for the "options" option
	    var options : string := "Options"
	    width := Font.Width (options, font)
	    % Draws the "Options" option
	    Font.Draw (options, round (maxx / 2 - width / 2), 421, font, black)
	    % If the user has clicked the "options" option
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 421 and y < 421 + ascent - descent and button = 1 and buttonheld = false then
		% Set the screen to the "Options" screen
		screen := 12
	    end if
	    % The string for the "Save" option
	    var saveToMenu : string := "Save and Quit to Main Menu"
	    width := Font.Width (saveToMenu, font)
	    % Draws the "Save" option
	    Font.Draw (saveToMenu, round (maxx / 2 - width / 2), 371, font, black)
	    % If the user has hit the "Save" option
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 371 and y < 371 + ascent - descent and button = 1 and buttonheld = false then
		% Save the current game
		saveGame (mapname)
		% Send the userback to the main menu loop
		exittomenu := true
	    end if
	    View.Update
	    % If the user is in the options screen
	elsif screen = 12 then
	    % Removes the curor as it would otherwise show in the top left corner when the user goes to enter a character
	    setscreen ("nocursor")
	    % Creates the font
	    font := Font.New ("Impact:22")
	    Font.Sizes (font, height, ascent, descent, internalLeading)
	    % Creates the strings for each option, We use the \ to escape the quotation mark so we can surround the keyvalue in quotes
	    var leftkeytext : string := "Left: \"" + leftkey + "\""
	    var rightkeytext : string := "Right: \"" + rightkey + "\""
	    var jumpkeytext : string := "Jump: \"" + jumpkey + "\""
	    var inventorykeytext : string := "Inventory: \"" + inventorykey + "\""
	    var sprintkeytext : string := "Sprint: \"" + sprintkey + "\""
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
		put : stream, inventorykey
		put : stream, sprintkey
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
		put : stream, inventorykey
		put : stream, sprintkey
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
		put : stream, inventorykey
		put : stream, sprintkey
		% Closes file to prevent errors
		close : stream
	    end if
	    width := Font.Width (inventorykeytext, font)
	    % Draws the inventory key text button thingy
	    Font.Draw (inventorykeytext, round (maxx / 2 - width / 2), 301, font, black)
	    % Checks if the user clicked the inventory key text button thingy
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 301 and y < 301 + ascent - descent and button = 1 and buttonheld = false then
		% Assigns the inventorykey variable to the inputted character
		inventorykey := getchar
		% Redirects to the main directory to prevent saving in wrong place
		Dir.Change (maindirectory)
		% Saves the key configurations
		open : stream, "datafiles/controls", put
		put : stream, leftkey
		put : stream, rightkey
		put : stream, jumpkey
		put : stream, inventorykey
		put : stream, sprintkey
		% Closes file to prevent errors
		close : stream
	    end if
	    width := Font.Width (sprintkeytext, font)
	    % Draws the sprint key text button thingy
	    Font.Draw (sprintkeytext, round (maxx / 2 - width / 2), 261, font, black)
	    % Checks if the user clicked the sprint key text button thingy
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 261 and y < 261 + ascent - descent and button = 1 and buttonheld = false then
		% Assigns the sprintkey variable to the inputted character
		sprintkey := getchar
		% Redirects to the main directory to prevent saving in wrong place
		Dir.Change (maindirectory)
		% Saves the key configurations
		open : stream, "datafiles/controls", put
		put : stream, leftkey
		put : stream, rightkey
		put : stream, jumpkey
		put : stream, inventorykey
		put : stream, sprintkey
		% Closes file to prevent errors
		close : stream
	    end if
	    %Draws the PlayerDrawing button
	    var PlayerDrawingText : string := "Draw Player Model: "
	    if playerdrawing = true then
		PlayerDrawingText += "Yes"
	    else
		PlayerDrawingText += "No"
	    end if
	    width := Font.Width (PlayerDrawingText, font)
	    Font.Draw (PlayerDrawingText, round (maxx / 2 - width / 2), 221, font, black)
	    %Checks to see if user clicked playerdrawnig button
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 221 and y < 221 + ascent - descent and button = 1 and buttonheld = false then
	    %Switches states
		if playerdrawing = true then
		    playerdrawing := false
		else
		    playerdrawing := true
		    legpivotx := positionx
		end if
	    end if
	    width := Font.Width (back, font)
	    % Draws the back button
	    Font.Draw (back, round (maxx / 2 - width / 2), 181, font, black)
	    % If the back button is clicked
	    if x > maxx / 2 - width / 2 and x < maxx / 2 + width / 2 and y > 181 and y < 181 + ascent - descent and button = 1 and buttonheld = false then
		% Redirect to the pause menu
		screen := 11
	    end if
	    % Re-enable cursor for map creation dialog boxes
	    setscreen ("cursor")
	    View.Update
	end if
    else
	% If the user is not supposed to be in the pause menu exit the pause menu
	exit
    end if
    % If the user is meant to go back to the main menu do so
    if exittomenu = true then
	exit
    end if
    if button = 0 then
	buttonheld := false
    else
	buttonheld := true
    end if
end loop
