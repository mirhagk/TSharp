%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%Minecraft 2D%%%%%%%%%
%%Created by: Jonathan Sells%%
%%Some textures and concepts%%
%%%are created by Mojang AB%%%
%%%%and are replicated for%%%%
%%%%%non-profit purposes.%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
import GUI
type item :
    record
	id : int
	amount : int
	durability : int4
    end record
type blockinfo :
    record
	name : string
	hardness : int
	weakness : int
	tooltyperequired : boolean
	tool : boolean
	tooltype : int
	strength : int
	durability : int
    end record
include "include/inventcrafting.t"
include "include/craftingtable.t"
var window : int := Window.Open ("graphics:801;641, offscreenonly")
% Saves the root directory of the program for later uses
var maindirectory : string := Dir.Current
% Loads images
var terrain : int := Pic.FileNew ("images/terrain.gif")
var items : int := Pic.FileNew ("images/items.gif")
var fullheart : int := Pic.FileNew ("images/full-heart.gif")
var halfheart : int := Pic.FileNew ("images/half-heart.gif")
var inventoryscreen : int := Pic.FileNew ("images/inventory.gif")
var craftingscreen : int := Pic.FileNew ("images/crafting.gif")
var background : int := Pic.FileNew ("images/Background.gif")
% Draws texture pack and creates images of each block
Pic.Draw (terrain, 0, 0, picCopy)
var breakinganimations : array 0 .. 9 of int
var textures : array 1 .. 256 of int
var blockinfos : array 0 .. 256 of blockinfo
for i : 0 .. 9
    breakinganimations (i) := Pic.New (16 * i, 0, 16 * i + 15, 15)
end for
blockinfos (0).name := ""
textures (1) := Pic.New (16, 224, 31, 239)
blockinfos (1).name := "Bedrock"
blockinfos (1).hardness := 2147483647
blockinfos (1).tool := false
textures (2) := Pic.New (16, 240, 31, 255)
blockinfos (2).name := "Stone"
blockinfos (2).hardness := 2250
blockinfos (2).weakness := 1
blockinfos (2).tooltyperequired := true
blockinfos (2).tool := false
textures (3) := Pic.New (32, 240, 47, 255)
blockinfos (3).name := "Dirt"
blockinfos (3).hardness := 750
blockinfos (3).weakness := 2
blockinfos (3).tooltyperequired := false
blockinfos (3).tool := false
textures (4) := Pic.New (48, 240, 63, 255)
blockinfos (4).name := "Grass"
blockinfos (4).hardness := 900
blockinfos (4).weakness := 2
blockinfos (4).tooltyperequired := false
blockinfos (4).tool := false
textures (5) := Pic.New (64, 240, 79, 255)
blockinfos (5).name := "Wood Plank"
blockinfos (5).hardness := 3000
blockinfos (5).weakness := 3
blockinfos (5).tooltyperequired := false
blockinfos (5).tool := false
textures (6) := Pic.New (64, 224, 79, 239)
blockinfos (6).name := "Wood"
blockinfos (6).hardness := 3000
blockinfos (6).weakness := 3
blockinfos (6).tooltyperequired := false
blockinfos (6).tool := false
textures (7) := Pic.New (16, 208, 31, 223)
blockinfos (7).name := "Iron Ore"
blockinfos (7).hardness := 4500
blockinfos (7).weakness := 1
blockinfos (7).tooltyperequired := true
blockinfos (7).tool := false
textures (8) := Pic.New (0, 208, 15, 223)
blockinfos (8).name := "Gold Ore"
blockinfos (8).hardness := 4500
blockinfos (8).weakness := 1
blockinfos (8).tooltyperequired := true
blockinfos (8).tool := false
textures (9) := Pic.New (32, 208, 47, 223)
blockinfos (9).name := "Coal Ore"
blockinfos (9).hardness := 4500
blockinfos (9).weakness := 1
blockinfos (9).tooltyperequired := true
blockinfos (9).tool := false
textures (10) := Pic.New (32, 192, 47, 207)
blockinfos (10).name := "Diamond Ore"
blockinfos (10).hardness := 4500
blockinfos (10).weakness := 1
blockinfos (10).tooltyperequired := true
blockinfos (10).tool := false
textures (12) := Pic.New (192, 192, 207, 207)
blockinfos (12).name := "Crafting Table"
blockinfos (12).hardness := 3750
blockinfos (12).weakness := 3
blockinfos (12).tooltyperequired := false
blockinfos (12).tool := false
textures (15) := Pic.New (0, 160, 15, 175)
blockinfos (15).name := "Torch"
blockinfos (15).hardness := 50
blockinfos (15).weakness := 0
blockinfos (15).tooltyperequired := false
blockinfos (15).tool := false
textures (16) := Pic.New (176, 224, 191, 239)
blockinfos (16).name := "Chest"
blockinfos (16).hardness := 3750
blockinfos (16).weakness := 3
blockinfos (16).tooltyperequired := false
blockinfos (16).tool := false
cls
Pic.Draw (items, 0, 0, picCopy)
textures (11) := Pic.New (80, 192, 95, 207)
blockinfos (11).name := "Stick"
blockinfos (11).tooltype := 0
blockinfos (11).strength := 1
blockinfos (11).tool := false
textures (13) := Pic.New (112, 192, 127, 207)
blockinfos (13).name := "Diamond Gem"
blockinfos (13).tooltype := 0
blockinfos (13).strength := 1
blockinfos (13).tool := false
textures (14) := Pic.New (112, 240, 127, 255)
blockinfos (14).name := "Coal"
blockinfos (14).tooltype := 0
blockinfos (14).strength := 1
blockinfos (14).tool := false
for i : 0 .. 4
    textures (20 + i) := Pic.New (i * 16, 144, i * 16 + 15, 159)
    blockinfos (20 + i).tooltype := 1
    blockinfos (20 + i).strength := i * 2 + 2
    blockinfos (20 + i).tool := true
end for
for i : 0 .. 4
    textures (30 + i) := Pic.New (i * 16, 160, i * 16 + 15, 175)
    blockinfos (30 + i).tooltype := 2
    blockinfos (30 + i).strength := i * 2 + 2
    blockinfos (30 + i).tool := true
end for
for i : 0 .. 4
    textures (40 + i) := Pic.New (i * 16, 128, i * 16 + 15, 143)
    blockinfos (40 + i).tooltype := 3
    blockinfos (40 + i).strength := i * 2 + 2
    blockinfos (40 + i).tool := true
end for
blockinfos (20).name := "Wood Pickaxe"
blockinfos (20).durability := 64
blockinfos (21).name := "Stone Pickaxe"
blockinfos (21).durability := 128
blockinfos (22).name := "Iron Pickaxe"
blockinfos (22).durability := 512
blockinfos (23).name := "Diamond Pickaxe"
blockinfos (23).durability := 1024
blockinfos (24).name := "Gold Pickaxe"
blockinfos (24).durability := 32
blockinfos (30).name := "Wood Shovel"
blockinfos (30).durability := 64
blockinfos (31).name := "Stone Shovel"
blockinfos (31).durability := 128
blockinfos (32).name := "Iron Shovel"
blockinfos (32).durability := 512
blockinfos (33).name := "Diamond Shovel"
blockinfos (33).durability := 1024
blockinfos (34).name := "Gold Shovel"
blockinfos (34).durability := 32
blockinfos (40).name := "Wood Axe"
blockinfos (40).durability := 64
blockinfos (41).name := "Stone Axe"
blockinfos (41).durability := 128
blockinfos (42).name := "Iron Axe"
blockinfos (42).durability := 512
blockinfos (43).name := "Diamond Axe"
blockinfos (43).durability := 1024
blockinfos (44).name := "Gold Axe"
blockinfos (44).durability := 32
cls
% Creates the record that will hold information about a specific block
type block :
    record
	blockid : int
	lightlevel : int
    end record
% Creates the record that holds the blocks in a chunk
type chunk :
    record
	blocks : array 0 .. 31 of array 1 .. 128 of block
    end record
% Creates the default key configuration
var jumpkey : char := " "
var rightkey : char := "d"
var leftkey : char := "a"
% This is used for a hotfix in the controls loading
var temp : char
% Verifies the user is in the main directory
Dir.Change (maindirectory)
% If the user has changed the controls they will have been saved so we load them, otherwise we leave them at default
if File.Exists ("controls.txt") then
    % Opens the controls file and loads the key configuration. Since we are assigning the values to characters we get new line characters between controls so we need to skip them.
    var stream : int
    open : stream, "controls.txt", get
    get : stream, leftkey
    get : stream, temp
    get : stream, rightkey
    get : stream, temp
    get : stream, jumpkey
    % Closes file to prevent errors
    close : stream
end if
var menumessages : flexible array 1 .. 0 of string
Dir.Change (maindirectory)
if File.Exists ("menumessages.txt") then
    var stream : int
    open : stream, "menumessages.txt", get
    loop
	exit when eof (stream)
	new menumessages, upper (menumessages) + 1
	get : stream, menumessages (upper (menumessages)) : *
    end loop
end if
% Allocates 11 chunk slots, this can be modified but requires a fair amount of editing.
var chunks : array 0 .. 10 of chunk
% Generates a random seed to be used if a new map is generated, this will be reassigned if loading a map
var seed : int := Rand.Int (0, 1073741824)
% X position of the players character
var positionx : int := 0
% Specifies the actual chunk index of the first chunk in the "chunks" array
var base : int := floor (positionx / 16 / 32) - 5
% Y position of the players character
var positiony : int := 64 * 16
% Creates the inventory and sets every clot to air
var inventory : array 1 .. 36 of item
for i : 1 .. 36
    inventory (i).id := 0
    inventory (i).amount := 0
end for
var table : array 1 .. 2 of array 1 .. 2 of item
for i : 1 .. 2
    for j : 1 .. 2
	table (i) (j).id := 0
	table (i) (j).amount := 0
    end for
end for
table (1) (1).id := 6
table (1) (1).amount := 64
var craftingtable : array 1 .. 3 of array 1 .. 3 of item
for i : 1 .. 3
    for j : 1 .. 3
	craftingtable (i) (j).id := 0
	craftingtable (i) (j).amount := 0
    end for
end for
craftingtable (1) (1).id := 24
craftingtable (1) (1).amount := 1
craftingtable (1) (2).id := 34
craftingtable (1) (2).amount := 1
% Specifies the players health, it is set to 20 by default (10 hearts) and is re-assigned if loading an existing map
var playerhealth : int := 20
% Creates the variable that holds accumulative falling damage
var damage : int := 0
var breaktimer : int := 0
var breakstage : int := -1
var breakingblockx : int := 0
var breakingblocky : int := 0
var hardness : int := 0
var timeframe : int := 0
var quitbool : boolean := false
% The procedure to generate a chunk, requires the chunk id being generated
process damaged
    Dir.Change (maindirectory)
    Music.PlayFile ("sounds/hurt.wav")
end damaged
procedure createChunk (id : int)
    % Adds the chunk index to the seed so that the chunk will generate the same no matter how many chunks have been loaded prior
    Rand.Set (seed + id)
    % Loops through every column in the map
    for i : 0 .. 31
	% Assigns air to all sky blocks
	for j : 64 .. 128
	    chunks (id - base).blocks (i) (j).blockid := 0
	end for
	% Assigns grass to the top layer of dirt
	chunks (id - base).blocks (i) (63).blockid := 4
	% Assigns the top 4 layers of ground to be dirt (Minus the layer of grass above)
	for j : 59 .. 62
	    chunks (id - base).blocks (i) (j).blockid := 3
	end for
	% Assigns Everything below grass and above bedrock to stone
	for j : 6 .. 58
	    chunks (id - base).blocks (i) (j).blockid := 2
	end for
	% Assigns bedrock to bottom 5 layers to prevent falling out of map
	for j : 1 .. 5
	    chunks (id - base).blocks (i) (j).blockid := 1
	end for
    end for
    % Loops through every column in the map
    for i : 0 .. 31
	% Loops through all coal-spawnable layers
	for j : 6 .. 56
	    % 1% chance of generating a vein of coal
	    if Rand.Int (0, 1000) < 10 then
		% Loops through all blocks in vein
		for k : 1 .. 3
		    for l : 1 .. 3
			% Prevents errors with creating a vein that goes out of the map
			if i + k < 32 then
			    % 2/3 chance of creating an ore at the specified spot in vein
			    if Rand.Int (1, 3) < 3 then
				% Creates the ore
				chunks (id - base).blocks (i + k - 1) (j + l - 1).blockid := 9
			    end if
			end if
		    end for
		end for
	    end if
	end for
	% Loops through all iron-spawnable layers
	for j : 6 .. 57
	    % 1% chance of generating a vein of iron
	    if Rand.Int (0, 1000) < 10 then
		% Loops through all blocks in vein
		for k : 1 .. 2
		    for l : 1 .. 2
			% Prevents errors with creating a vein that goes out of the map
			if i + k < 32 then
			    % 2/3 chance of creating an ore at the specified spot in vein
			    if Rand.Int (1, 3) < 3 then
				% Creates the ore
				chunks (id - base).blocks (i + k - 1) (j + l - 1).blockid := 7
			    end if
			end if
		    end for
		end for
	    end if
	end for
	% Loops through all gold-spawnable layers
	for j : 6 .. 32
	    % 0.6% chance of generating a vein of gold
	    if Rand.Int (0, 1000) < 8 then
		% Loops through all blocks in vein
		for k : 1 .. 2
		    for l : 1 .. 2
			% Prevents errors with creating a vein that goes out of the map
			if i + k < 32 then
			    % 2/3 chance of creating an ore at the specified spot in vein
			    if Rand.Int (1, 3) < 3 then
				% Creates the ore
				chunks (id - base).blocks (i + k - 1) (j + l - 1).blockid := 8
			    end if
			end if
		    end for
		end for
	    end if
	end for
	% Loops through all diamond-spawnable layers
	for j : 6 .. 19
	    % 0.5% chance of generating a vein of iron
	    if Rand.Int (0, 1000) < 5 then
		% Loops through all blocks in vein
		for k : 1 .. 2
		    for l : 1 .. 2
			% Prevents errors with creating a vein that goes out of the map
			if i + k < 32 then
			    % 2/3 chance of creating an ore at the specified spot in vein
			    if Rand.Int (1, 3) < 3 then
				% Creates the ore
				chunks (id - base).blocks (i + k - 1) (j + l - 1).blockid := 10
			    end if
			end if
		    end for
		end for
	    end if
	end for
    end for
end createChunk
% The procedure to load a chunk, requires the chunk id and the mapname to load from
procedure loadChunk (id : int, mapname : string)
    % Resets current directory to the root of the project
    Dir.Change (maindirectory)
    % Verifies that there is a saves folder, if the is not then it gets created
    if Dir.Exists (Dir.Current + "/saves") = false then
	Dir.Create ("saves")
    end if
    Dir.Change (Dir.Current + "/saves")
    % Verifies that the map that is being loaded does exist, if not it again creates it. Since we have already checked for this earlier this should never occur, but we do it for good measure.
    if Dir.Exists (Dir.Current + "/" + mapname) = false then
	Dir.Create (mapname)
    end if
    Dir.Change (Dir.Current + "/" + mapname)
    % Verifies that the map being loaded contains the chunks directory, if not it creates it
    if Dir.Exists (Dir.Current + "/chunks") = false then
	Dir.Create ("chunks")
    end if
    Dir.Change (Dir.Current + "/chunks")
    % Verifies that the chunk that is being loaded exists, if it does not it creates the chunk
    if Dir.Exists (intstr (id)) = false then
	createChunk (id)
    else
	% If the chunk exists, we may navigate into the chunk folder and load the chunk data
	Dir.Change (intstr (id))
	% We open the file for reading
	var stream : int
	open : stream, "blocks.txt", get
	% The file is arranged to read/write with a single block per line, they are ordered by x co-ordinate then by y co-ordinate
	for j : 0 .. 31
	    for k : 1 .. 128
		% Assigns the corresponding block to its place in the chunk
		get : stream, chunks (id - base).blocks (j) (k).blockid
	    end for
	end for
	% Closes the file to prevent errors
	close : stream
    end if

end loadChunk
% The procedire to save a chunk, this is practically identical to loading except it saves instead or loading, again requiring a chunk id and mapname.
procedure saveChunk (id : int, mapname : string)
    % Resets current directory to the root of the project
    Dir.Change (maindirectory)
    % Verifies that there is a saves folder, if the is not then it gets created
    if Dir.Exists (Dir.Current + "/saves") = false then
	Dir.Create ("saves")
    end if
    Dir.Change (Dir.Current + "/saves")
    % Verifies that the map that is being saved does exist, if not it again creates it.
    if Dir.Exists (Dir.Current + "/" + mapname) = false then
	Dir.Create (mapname)
    end if
    Dir.Change (Dir.Current + "/" + mapname)
    % Verifies that the map being saved contains the chunks directory, if not it creates it
    if Dir.Exists (Dir.Current + "/chunks") = false then
	Dir.Create ("chunks")
    end if
    Dir.Change (Dir.Current + "/chunks")
    % Verifies that the chunk that is being saved has a corresponding folder in the map files, if it does not it creates the folder
    if Dir.Exists (intstr (id)) = false then
	Dir.Create (intstr (id))
    end if
    % We open the chunk folder for saving
    Dir.Change (intstr (id))
    % We create / overwrite any existing files
    var stream : int
    open : stream, "blocks.txt", put
    % The file is arranged to read/write with a single block per line, they are ordered by x co-ordinate then by y co-ordinate
    for j : 0 .. 31
	for k : 1 .. 128
	    % Writes the current block
	    put : stream, chunks (id - base).blocks (j) (k).blockid
	end for
    end for
    % Closes the file to prevent errors
    close : stream

end saveChunk
% The procedure to save the game
procedure saveGame (mapname : string)
    % Saves the 6 chunks around the player and the one that contains the player. We do not need to save the outer chunks as they cannot be modified when the character is in its current position
    saveChunk (floor (positionx / 16 / 32) - 3, mapname)
    saveChunk (floor (positionx / 16 / 32) - 2, mapname)
    saveChunk (floor (positionx / 16 / 32) - 1, mapname)
    saveChunk (floor (positionx / 16 / 32), mapname)
    saveChunk (floor (positionx / 16 / 32) + 1, mapname)
    saveChunk (floor (positionx / 16 / 32) + 2, mapname)
    saveChunk (floor (positionx / 16 / 32) + 3, mapname)
    % Relocates to the root directory so we can save it in the desired location
    Dir.Change (maindirectory)
    % Verifies that the saves folder exists, if not we create it
    if Dir.Exists (Dir.Current + "/saves") = false then
	Dir.Create ("saves")
    end if
    Dir.Change (Dir.Current + "/saves")
    % Verifies that there is a folder for the current map, again it will create it if not
    if Dir.Exists (Dir.Current + "/" + mapname) = false then
	Dir.Create (mapname)
    end if
    Dir.Change (Dir.Current + "/" + mapname)
    % Creates/Overwrites the current level data file
    var stream : int
    open : stream, "level.txt", put
    % Writes the seed, location, health and inventory into the file
    put : stream, seed
    put : stream, positionx
    put : stream, positiony
    put : stream, playerhealth
    put : stream, damage
    for i : 1 .. 36
	put : stream, inventory (i).id
	put : stream, inventory (i).amount
    end for
    % Closes file to prevent errors
    close : stream
end saveGame
% the procedure to load a game
procedure loadGame (mapname : string)
    % Navigates to the root directory to locate the saved game properly
    Dir.Change (maindirectory)
    % In order to be able to load we already know that the saves and map folder exits so we can simply navigate to them
    Dir.Change (Dir.Current + "/saves")
    Dir.Change (Dir.Current + "/" + mapname)
    % Opens the level data file to retrieve the seed, location, health and inventory
    var stream : int
    open : stream, "level.txt", get
    get : stream, seed
    get : stream, positionx
    get : stream, positiony
    get : stream, playerhealth
    get : stream, damage
    for i : 1 .. 36
	get : stream, inventory (i).id
	get : stream, inventory (i).amount
    end for
    % Closes file to prevent errors
    close : stream
    % Re-assigns the base according to the new player positions
    base := floor (positionx / 16 / 32) - 5
    % Loads/Creates all necessary chunks around the player
    loadChunk (floor (positionx / 16 / 32), mapname)
    loadChunk (floor (positionx / 16 / 32) - 1, mapname)
    loadChunk (floor (positionx / 16 / 32) - 2, mapname)
    loadChunk (floor (positionx / 16 / 32) - 3, mapname)
    loadChunk (floor (positionx / 16 / 32) - 4, mapname)
    loadChunk (floor (positionx / 16 / 32) - 5, mapname)
    loadChunk (floor (positionx / 16 / 32) + 1, mapname)
    loadChunk (floor (positionx / 16 / 32) + 2, mapname)
    loadChunk (floor (positionx / 16 / 32) + 3, mapname)
    loadChunk (floor (positionx / 16 / 32) + 4, mapname)
    loadChunk (floor (positionx / 16 / 32) + 5, mapname)
end loadGame
% This variable controls whether the player is in the menu screen or in-game
var playing : boolean := false
% This is a required procedure for the text field, just ignore that it exists all together :P
procedure mapNameEntered (text : string)
end mapNameEntered
% The procedure that is called when a map is chosen to be created.
procedure createMap
    % Creates the necessary chunks
    for i : -5 .. 5
	createChunk (i)
    end for
    % Tells the game that the map is loaded and the menu can be closed
    playing := true
    % Uses GUI.Quit to tell the game that the map is ready to play
    GUI.Quit
end createMap
% Creates the mapname variable
var mapname : string
% Redirects to the main directory to ensure correct loading
Dir.Change (maindirectory)
% Loads the Menu Background
var MenuBG : int := Pic.FileNew ("images/MenuBG.gif")






Dir.Change (maindirectory)
include "include/mainmenu.t"






% The function that returns a block based on a pixel co-ordinate
function getblockfloor (x, y : int) : block
    % Checks to makes sure that the block is within the height boundaries of the map
    if floor ((y) / 16) < 129 and floor ((y) / 16) > 0 then
	% Returns the block
	result chunks (floor (((x) / 16) / 32) - base).blocks (floor ((x) / 16) mod 32) (floor (y / 16))
    else
	% If the block is outside the height limitations of the map it returns an air block (Doesn't draw)
	var emptyblock : block
	emptyblock.blockid := 0
	result emptyblock
    end if
end getblockfloor
loop
    % Redirects to main directory to prevent read errors
    Dir.Change (maindirectory)
    % The array to hold all saved game names
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
	new mapnames, upper (mapnames) + 1
	mapnames (upper (mapnames)) := Dir.Get (streamNumber)
	exit when mapnames (upper (mapnames)) = ""
    end loop
    % Closes the directory to prevent errors
    Dir.Close (streamNumber)
    % Calls the main menu function to display the main menu
    MainMenu
    if quitbool = true then
	Window.Close (window)
	return
    end if
    % Checks if the mapname is one of the already made maps, if so it calls the loadgame procedure
    for i : 3 .. upper (mapnames) - 1
	if mapname = mapnames (i) then
	    loadGame (mapname)
	end if
    end for
    % Creates the timer for the FPS counter
    var elapsedtime : int := Time.Elapsed
    % Creates the variable that represents the currently selected inventory item
    var currentblock := 1
    % Sets the horizontal movement speed
    const movespeed := 4
    % Creates the variables for drawing
    var leftblockx, rightblockx, bottomblocky, topblocky, xoffset, yoffset : int
    % Creates the variable for the accumulated damage over a falling distance
    % Creates the variable that tells whether the user is on the ground or not
    var collision : boolean := true
    % Creates the variable that will hold the accumulated verticle velocity
    var yvelocity : int := 0
    % Creates the gravity and terminal velocity constants, these effect jump height and falling speed
    const gravity := -1
    const terminalvelocity := 16
    var chars : array char of boolean
    var x, y, button : int
    var screen : int := 11
    % Allows for right clicks and middle mouse clicks to be registered
    Mouse.ButtonChoose ("multibutton")
    loop
	% Records the users input
	Input.KeyDown (chars)
	Mouse.Where (x, y, button)
	% If the character is jumping and is on the ground then the yvelocity is set to be jumping and sets the collision (On ground) variable to false
	if chars (jumpkey) and collision then
	    collision := false
	    yvelocity := 7
	end if
	% If the player has not reached terminal velocity then add gravity to the players velocity
	if yvelocity > -terminalvelocity then
	    yvelocity += gravity
	    % If the are at or above terminal velocity limit the player to terminal velocity
	else
	    yvelocity := -terminalvelocity
	end if
	% If the player is on the falling portion of their jump add the velocity to the accumulative damage
	if yvelocity < 0 then
	    damage -= yvelocity
	end if
	% Set the collision (On ground) to false so the user cannot jump mid-air if he/she walks off a ledge
	collision := false
	% If the right side of the player or the left side of the player is on a block then
	if getblockfloor (positionx, positiony + yvelocity).blockid not= 0
		or getblockfloor (positionx + 15, positiony + yvelocity).blockid not= 0 then
	    % Set the collison (On ground) to true
	    collision := true
	    % If the damage is greater than 64 (4 blocks fall) then subtract 4 blocks from the damage and subtract the damage from the players health
	    if damage > 64 then
		fork damaged
		damage -= 64
		playerhealth -= floor (damage / 16)
	    end if
	    % Reset the damage and velocity variables for the next fall
	    damage := 0
	    yvelocity := 0
	    % Set the player onto the ground
	    positiony := floor (positiony / 16) * 16
	    %If the user has hit their head, drop their velocity to 0 so they begin falling again
	elsif getblockfloor (positionx, positiony + yvelocity + 31).blockid not= 0 or
		getblockfloor (positionx + 15, positiony + yvelocity + 31).blockid not= 0 then
	    yvelocity := 0
	    % If the user has not hit the ground or their head then add the velocity to the players y co-ordinate
	else
	    positiony += yvelocity
	end if
	% If the player is dead
	if playerhealth <= 0 then
	    % Draw the menu background
	    Pic.Draw (MenuBG, 0, 0, picCopy)
	    % Create the font for the death message
	    var font := Font.New ("Impact:36")
	    var height, ascent, descent, internalLeading : int
	    Font.Sizes (font, height, ascent, descent, internalLeading)
	    % The string to hold the death message
	    var youDied : string := "Ouch, that must've hurt"
	    var width := Font.Width (youDied, font)
	    % Draws the death message
	    Font.Draw (youDied, round (maxx / 2 - width / 2), 541, font, black)
	    % Creates the font for the respawn message
	    font := Font.New ("Impact:28")
	    % The string to hold the respawn text
	    var respawn : string := "Press Enter To Respawn"
	    width := Font.Width (respawn, font)
	    % Draws the respawn message
	    Font.Draw (respawn, round (maxx / 2 - width / 2), 481, font, black)
	    View.Update
	    % Delays so the menu doesn't immediately exit if the player was pressing enter when they died
	    Time.Delay (100)
	    % Loops until the player attempts to respawn
	    loop
		% Gets the players inputted keystroke
		Input.KeyDown (chars)
		% If the player hits enter reset their positions and health
		if chars (KEY_ENTER) then
		    positionx := 0
		    positiony := 64 * 16
		    playerhealth := 20
		    exit
		end if
	    end loop
	end if
	% If the character is moving right
	if chars (rightkey) then
	    % If the block at the players feet after moving is air then continue
	    if getblockfloor (positionx + movespeed + 15, positiony).blockid = 0 then
		% If the block at the players torso after moving is air then continue
		if getblockfloor (positionx + movespeed + 15, positiony + 15).blockid = 0 then
		    % If the block at the players head after moving is air then continue
		    if getblockfloor (positionx + movespeed + 15, positiony + 31).blockid = 0 then
			% If after moving the player is in an outer chunk then
			if floor ((positionx + movespeed) / 16 / 32) - base = 8 then
			    % Save the 3 chunks leftmost before unloading them
			    saveChunk (floor (positionx / 16 / 32) - 7, mapname)
			    saveChunk (floor (positionx / 16 / 32) - 6, mapname)
			    saveChunk (floor (positionx / 16 / 32) - 5, mapname)
			    % Shift all chunks over to the left by 3
			    chunks ((floor ((positionx) / 16 / 32) - 7) - base) := chunks ((floor ((positionx) / 16 / 32) - 4) - base)
			    chunks ((floor ((positionx) / 16 / 32) - 6) - base) := chunks ((floor ((positionx) / 16 / 32) - 3) - base)
			    chunks ((floor ((positionx) / 16 / 32) - 5) - base) := chunks ((floor ((positionx) / 16 / 32) - 2) - base)
			    chunks ((floor ((positionx) / 16 / 32) - 4) - base) := chunks ((floor ((positionx) / 16 / 32) - 1) - base)
			    chunks ((floor ((positionx) / 16 / 32) - 3) - base) := chunks ((floor ((positionx) / 16 / 32)) - base)
			    chunks ((floor ((positionx) / 16 / 32) - 2) - base) := chunks ((floor ((positionx) / 16 / 32) + 1) - base)
			    chunks ((floor ((positionx) / 16 / 32) - 1) - base) := chunks ((floor ((positionx) / 16 / 32) + 2) - base)
			    chunks ((floor ((positionx) / 16 / 32)) - base) := chunks ((floor ((positionx) / 16 / 32) + 3) - base)
			    % Increase the base chunk by 3
			    base += 3
			    % Load the next 3 chunks to the right
			    loadChunk (floor ((positionx) / 16 / 32) + 4, mapname)
			    loadChunk (floor ((positionx) / 16 / 32) + 5, mapname)
			    loadChunk (floor ((positionx) / 16 / 32) + 6, mapname)
			end if
			% Increase the position by the movement speed
			positionx += movespeed
		    end if
		end if
	    end if
	end if
	% If the character is moving left
	if chars (leftkey) then
	    % If the block at the players feet after moving is air then continue
	    if getblockfloor (positionx - movespeed, positiony).blockid = 0 then
		% If the block at the players torso after moving is air then continue
		if getblockfloor (positionx - movespeed, positiony + 15).blockid = 0 then
		    % If the block at the players head after moving is air then continue
		    if getblockfloor (positionx - movespeed, positiony + 31).blockid = 0 then
			% If after moving the player is in an outer chunk then
			if floor ((positionx - movespeed) / 16 / 32) - base = 2 then
			    % Save the 3 chunks rightmost before unloading them
			    saveChunk (floor (positionx / 16 / 32) + 7, mapname)
			    saveChunk (floor (positionx / 16 / 32) + 6, mapname)
			    saveChunk (floor (positionx / 16 / 32) + 5, mapname)
			    % Shift all chunks over to the right by 3
			    chunks ((floor ((positionx) / 16 / 32) + 7) - base) := chunks ((floor ((positionx) / 16 / 32) + 4) - base)
			    chunks ((floor ((positionx) / 16 / 32) + 6) - base) := chunks ((floor ((positionx) / 16 / 32) + 3) - base)
			    chunks ((floor ((positionx) / 16 / 32) + 5) - base) := chunks ((floor ((positionx) / 16 / 32) + 2) - base)
			    chunks ((floor ((positionx) / 16 / 32) + 4) - base) := chunks ((floor ((positionx) / 16 / 32) + 1) - base)
			    chunks ((floor ((positionx) / 16 / 32) + 3) - base) := chunks ((floor ((positionx) / 16 / 32)) - base)
			    chunks ((floor ((positionx) / 16 / 32) + 2) - base) := chunks ((floor ((positionx) / 16 / 32) - 1) - base)
			    chunks ((floor ((positionx) / 16 / 32) + 1) - base) := chunks ((floor ((positionx) / 16 / 32) - 2) - base)
			    chunks ((floor ((positionx) / 16 / 32)) - base) := chunks ((floor ((positionx) / 16 / 32) - 3) - base)
			    % Decrease the base chunk by 3
			    base -= 3
			    % Load the next 3 chunks to the left
			    loadChunk (floor ((positionx) / 16 / 32) - 4, mapname)
			    loadChunk (floor ((positionx) / 16 / 32) - 5, mapname)
			    loadChunk (floor ((positionx) / 16 / 32) - 6, mapname)
			end if
			% Decrease the position by the movement speed
			positionx -= movespeed
		    end if
		end if
	    end if
	end if
	% Resets the exittomenu boolean to false
	var exittomenu : boolean := false
	% If the player presses the escape key, open the pause menu
	if chars (KEY_ESC) then
	    Dir.Change (maindirectory)
	    include "include/pausemenu.t"
	end if
	% If the player is meant to exit to the main menu do so
	if exittomenu = true then
	    exit
	end if
	% If the player presses the button to select the first inventory slot set the current inventory block to #1
	if chars ('1') then
	    currentblock := 1
	    % If the player presses the button to select the second inventory slot set the current inventory block to #2
	elsif chars ('2') then
	    currentblock := 2
	    % If the player presses the button to select the third inventory slot set the current inventory block to #3
	elsif chars ('3') then
	    currentblock := 3
	    % If the player presses the button to select the fourth inventory slot set the current inventory block to #4
	elsif chars ('4') then
	    currentblock := 4
	    % If the player presses the button to select the fifth inventory slot set the current inventory block to #5
	elsif chars ('5') then
	    currentblock := 5
	    % If the player presses the button to select the sixth inventory slot set the current inventory block to #6
	elsif chars ('6') then
	    currentblock := 6
	    % If the player presses the button to select the seventh inventory slot set the current inventory block to #7
	elsif chars ('7') then
	    currentblock := 7
	    % If the player presses the button to select the eighth inventory slot set the current inventory block to #8
	elsif chars ('8') then
	    currentblock := 8
	    % If the player presses the button to select the ninth inventory slot set the current inventory block to #9
	elsif chars ('9') then
	    currentblock := 9
	end if
	if chars ('e') then
	    var inventbackground : int := Pic.New (0, 0, maxx, maxy)
	    Dir.Change (maindirectory)
	    include "include/inventory.t"
	end if
	% If the player is pressing one of the mouse buttons
	if button = 1 or button = 100 then
	    % If the mouse is inside the game window
	    if x > 0 and x < 801 and y > 0 and y < 641 then
		var blockx, blocky : int
		% Determine the block co-ordinate based on the mouses x position
		if x < maxx div 2 then
		    blockx := floor (positionx - maxx / 2 + x)
		else
		    blockx := floor (positionx + x - (maxx / 2))
		end if
		% Determine the block co-ordinate based on the mouses y position
		if y < maxy div 2 then
		    blocky := floor (positiony - maxy / 2 + y)
		else
		    blocky := floor (positiony + y - (maxy / 2))
		end if
		% If the block is within the building heights
		if floor (blocky / 16) > 0 and floor (blocky / 16) < 124 then
		    % If the block is not inside the player
		    if ((floor (blockx / 16) = floor (positionx / 16) and floor (blocky / 16) = floor (positiony / 16))
			    or (floor (blockx / 16) = floor (positionx / 16) and (floor (blocky / 16)) = floor ((positiony + 31) / 16))
			    or (floor (blockx / 16) = floor (positionx / 16) and (floor (blocky / 16)) = floor ((positiony + 16) / 16))
			    or (floor (blockx / 16) = floor ((positionx + 15) / 16) and floor (blocky / 16) = floor (positiony / 16))
			    or (floor (blockx / 16) = floor ((positionx + 15) / 16) and (floor (blocky / 16)) = floor ((positiony + 31) / 16))
			    or (floor (blockx / 16) = floor ((positionx + 15) / 16) and (floor (blocky / 16)) = floor ((positiony + 16) / 16)))
			    = false then
			% If the left button is pressed
			if button = 1 then
			    if chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid not= 0 then
				if chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid not= 1 then
				    hardness := blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).hardness
				    breaktimer += timeframe
				    if blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).weakness not= 0 then
					if inventory (currentblock).id not= 0 then
					    if blockinfos (inventory (currentblock).id).tool = true then
						if blockinfos (inventory (currentblock).id).tooltype = blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod
							32) (floor (blocky /
							16)).blockid).weakness then
						    hardness := floor (hardness / blockinfos (inventory (currentblock).id).strength)
						    breakstage := floor (breaktimer * 10 / hardness)
						else
						    breakstage := floor (breaktimer * 10 / blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod
							32) (floor (blocky /
							16)).blockid).hardness)
						end if
					    else
						breakstage := floor (breaktimer * 10 / blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod
						    32) (floor (blocky /
						    16)).blockid).hardness)
					    end if
					else
					    breakstage := floor (breaktimer * 10 / blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky /
						16)).blockid).hardness)
					end if
				    else
					breakstage := floor (breaktimer * 10 / blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky /
					    16)).blockid).hardness)
				    end if
				    if (breakingblockx not= blockx div 16) or (breakingblocky not= blocky div 16) then
					breakstage := -1
					breaktimer := 0
				    end if
				    breakingblockx := blockx div 16
				    breakingblocky := blocky div 16
				    if breaktimer >= hardness then
					if chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid = 10 then
					    var addedtoinventory : boolean := false
					    for i : 1 .. 36
						if inventory (i).id = 13 then
						    inventory (i).amount += 1
						    addedtoinventory := true
						    exit
						end if
					    end for
					    if addedtoinventory = false then
						for i : 1 .. 36
						    if inventory (i).id = 0 then
							inventory (i).id := 13
							inventory (i).amount := 1
							addedtoinventory := true
							exit
						    end if
						end for
					    end if
					elsif chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid = 9 then
					    var addedtoinventory : boolean := false
					    for i : 1 .. 36
						if inventory (i).id = 14 then
						    inventory (i).amount += 1
						    addedtoinventory := true
						    exit
						end if
					    end for
					    if addedtoinventory = false then
						for i : 1 .. 36
						    if inventory (i).id = 0 then
							inventory (i).id := 14
							inventory (i).amount := 1
							addedtoinventory := true
							exit
						    end if
						end for
					    end if
					else
					    var addedtoinventory : boolean := false
					    for i : 1 .. 36
						if inventory (i).id = chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid then
						    inventory (i).id := chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid
						    inventory (i).amount += 1
						    addedtoinventory := true
						    exit
						end if
					    end for
					    if addedtoinventory = false then
						for i : 1 .. 36
						    if inventory (i).id = 0 then
							inventory (i).id := chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid
							inventory (i).amount := 1
							addedtoinventory := true
							exit
						    end if
						end for
					    end if
					end if
					if blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).weakness not= 0 then
					    if inventory (currentblock).id not= 0 then
						if blockinfos (inventory (currentblock).id).tool = true then
						    if blockinfos (inventory (currentblock).id).tooltype = blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod
							    32) (floor (blocky /
							    16)).blockid).weakness then
							inventory (currentblock).durability += 1
							if inventory (currentblock).durability >= blockinfos (inventory (currentblock).id).durability then
							    inventory (currentblock).id := 0
							    inventory (currentblock).amount := 0
							    inventory (currentblock).durability := 0
							end if
						    end if
						else
						    breakstage := floor (breaktimer * 10 / blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod
							32) (floor (blocky /
							16)).blockid).hardness)
						end if
					    else
						breakstage := floor (breaktimer * 10 / blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky /
						    16)).blockid).hardness)
					    end if
					end if
					chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid := 0
					breaktimer := 0
					breakstage := -1
				    end if
				else
				    breaktimer := 0
				    breakstage := -1
				end if
			    else
				breaktimer := 0
				breakstage := -1
			    end if
			    % If the right mouse button is selected
			elsif button = 100 then
			    breaktimer := 0
			    breakstage := -1
			    % If the block being attempted to be modified is an air block
			    if getblockfloor (blockx, blocky).blockid = 0 then
				if inventory (currentblock).id not= 0 and inventory (currentblock).id not= 11 and inventory (currentblock).id not= 13 and inventory (currentblock).id not= 14 then
				    % Set the block selected to the currently selected inventory block
				    chunks ((floor (((blockx) / 16) / 32)) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid := inventory (currentblock).id
				    inventory (currentblock).amount -= 1
				    if inventory (currentblock).amount <= 0 then
					inventory (currentblock).id := 0
					inventory (currentblock).amount := 0
				    end if
				end if
			    elsif getblockfloor (blockx, blocky).blockid = 12 then
				Dir.Change (maindirectory)
				var craftingbackground : int := Pic.New (0, 0, maxx, maxy)
				include "include/crafting.t"
			    end if
			end if
		    end if
		end if
	    end if
	else
	    breaktimer := 0
	    breakstage := -1
	end if
	% Calculates the left right top and bottom blocks by subtracting or adding half the screen as the player will always be centered
	Pic.Draw (background, 0, 0, picCopy)
	leftblockx := round (positionx - maxx / 2)
	rightblockx := round (positionx + maxx / 2)
	bottomblocky := round (positiony - maxy / 2)
	topblocky := round (positiony + maxy / 2)
	% x and y offsets are calculated be getting the remainding pixels of the block that will be cut off
	xoffset := -round (positionx mod 16)
	yoffset := -round (positiony mod 16)
	% Loops through every block on the x axis of the screen
	for i : xoffset .. maxx + xoffset by 16
	    % Loops through every block on the y axis of the screen
	    for j : yoffset .. maxy + yoffset by 16
		% Verifies that the block being drawn is within the boundaries of the map
		if (bottomblocky + (j - yoffset)) div 16 >= 1 and (topblocky - (j - yoffset)) div 16 <= 128 then
		    % Only draws the block if it is not sky
		    if getblockfloor (((leftblockx + (i - xoffset))), ((bottomblocky + (j - yoffset)))).blockid not= 0 then
			% Draws the block at the current position. The block is calculated by adding the offset (Offset is negative so we have to subtract it to get it positive)
			% to the current position on the screen and then added to the left/bottom blocks position.
			% This is then divided by 16 so we can get it from the blocks array
			if getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j - yoffset)).blockid = 15 then
			    Pic.Draw (textures (getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j - yoffset)).blockid), i, j, picMerge)
			else
			    Pic.Draw (textures (getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j - yoffset)).blockid), i, j, picCopy)
			end if
		    end if
		end if
	    end for
	end for
	if breakstage > -1 and breakstage < 10 then
	    Pic.Draw (breakinganimations (breakstage), (floor ((x - xoffset) div 16) * 16) + xoffset, (floor ((y - yoffset) div 16) * 16) + yoffset, picMerge)
	end if
	% Draws the inventory items
	for i : 1 .. 9
	    % If the block being drawn is the currently selected block
	    if i = currentblock then
		% Draw a red blox behind it
		Draw.FillBox ((maxx div 2) - 112 + (10 * (i - 1)) + ((i - 1) * 16) - 2, 3, (maxx div 2) - 112 + (10 * (i - 1)) + ((i - 1) * 16) + 17, 22, red)
	    else
		% Draw a black box behind it
		Draw.FillBox ((maxx div 2) - 112 + (10 * (i - 1)) + ((i - 1) * 16) - 1, 4, (maxx div 2) - 112 + (10 * (i - 1)) + ((i - 1) * 16) + 16, 21, black)
	    end if
	    var font := Font.New ("Impact:8")
	    if inventory (i).id > 0 then
		% Draws each inventory block with a 10 pixel gap between blocks
		if inventory (i).id = 11 or inventory (i).id = 13 or inventory (i).id = 14 or inventory (i).id = 15 or (inventory (i).id >= 20 and inventory (i).id <= 24)
			or (inventory (i).id >= 30 and inventory (i).id <= 34) or (inventory (i).id >= 40 and inventory (i).id <= 44) then
		    Pic.Draw (textures (inventory (i).id), (maxx div 2) - 112 + (10 * (i - 1)) + ((i - 1) * 16), 5, picMerge)
		else
		    Pic.Draw (textures (inventory (i).id), (maxx div 2) - 112 + (10 * (i - 1)) + ((i - 1) * 16), 5, picCopy)
		end if
		Font.Draw (intstr (inventory (i).amount), (maxx div 2) - 112 + (10 * (i - 1)) + ((i - 1) * 16) + 1, 6, font, white)
		if ((inventory (i).id >= 20 and inventory (i).id <= 24) or (inventory (i).id >= 30 and inventory (i).id <= 34) or (inventory (i).id >= 40 and inventory (i).id <= 44))
			and (inventory (i).durability > 0) then
		    Draw.FillBox ((maxx div 2) - 112 + (10 * (i - 1)) + ((i - 1) * 16) - 1, 1, round ((maxx div 2) - 112 + (10 * (i - 1)) + ((i - 1) * 16) + (16
			* ((blockinfos (inventory (i).id).durability - inventory (i).durability) /
			blockinfos (inventory (i).id).durability))), 4, yellow)
		end if
	    end if
	end for
	% Draws the health bar
	for i : 1 .. 20
	    % If the current position in the loop is an odd number and is less than the players health we know that we need to draw a full heart
	    if i mod 2 = 1 and i < playerhealth then
		Pic.Draw (fullheart, (maxx div 2) - 112 + (((i - 1)) + ((i - 1) * 18) div 2 - 3), 25, picMerge)
	    end if
	    % If the current position in the loop is an odd number and is equal to the players health we need to draw a half heart as the players health is odd
	    if i mod 2 = 1 and i = playerhealth then
		Pic.Draw (halfheart, (maxx div 2) - 112 + (((i - 2)) + ((i - 2) * 18) div 2 + 7), 25, picMerge)
	    end if
	end for
	% Draw the player, he is currently a box but that will be updated at a later time
	Draw.FillBox (maxx div 2, maxy div 2, maxx div 2 + 15, maxy div 2 + 31, black)
	% Output the FPS
	put "FPS: ", 1000 div (Time.Elapsed - elapsedtime), "/25" ..
	timeframe := Time.Elapsed - elapsedtime
	elapsedtime := Time.Elapsed
	% Use View.Update, and Time.DelaySinceLast to create a smooth animation
	View.Update
	% Since we are not clearing the screen we relocate the text drawing position to the default to draw the debugging stuff correctly
	locate (1, 1)
	% Delays to create 25 FPS
	Time.DelaySinceLast (40)
    end loop
end loop
