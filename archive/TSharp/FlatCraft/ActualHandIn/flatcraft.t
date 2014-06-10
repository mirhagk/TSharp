%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%Minecraft 2D%%%%%%%%%
%%Created by: Jonathan Sells%%
%%Some textures and concepts%%
%%%are created by Mojang AB%%%
%%%%and are replicated for%%%%
%%%%%non-profit purposes.%%%%%
%%%%Sky Images created by:%%%%
%lynchmob10-09.deviantart.com%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Imports GUI for getting suer input for new map naming.
import GUI
%Variable to control the default state of character model drawing, this can be changed ingame though.
var playerdrawing : boolean := true
%Data record for items
type item :
    record
	%Which item is being stored
	id : int4
	%How much of it
	amount : int4
	%How many uses has the player used of this item
	durability : int4
    end record
%Data record for block type information
type blockinfo :
    record
	%The string of text that labels the block/item in the inventory window upon roll-over
	name : string
	%How many milliseconds it takes to break the block by default
	hardness : int4
	%Which tool is effective on this block
	weakness : int4
	%Is the tool requried to retrieve the block?
	tooltyperequired : boolean
	%Is the block/item a tool?
	tool : boolean
	%What kind of tool is it
	tooltype : int4
	%How strong is it(Multiplier)
	strength : int4
	%How many uses can be used before breaking
	durability : int4
	%Whether or not it can be added as a block to the world
	placable : int4
    end record
%Data record for block entities
type blockentity :
    record
	%Which block is being stored
	id : int4
	%How much
	amount : int4
	%How many uses have been used on this block
	durability : int4
	%Where is it located in the world
	x : int4
	y : int4
	%How long has it been there
	timer : int4
    end record
%Data record for mobs
type mobentity :
    record
	%Which mob are they
	idtype : int4
	%How much health do they have
	health : int4
	%X position
	x : real4
	%Y position
	y : real4
	%Y velocity
	yvelocity : real4
	%Accumulative damage during fall
	damage : real4
	%How long the mob has been on fire for, 0 means not on fire, anything bigger acts as a counter
	onfire : real4
	%Which stage of firedamage recently taken
	firestage : int4
	%Whether the mob is on the ground or not
	collision : int4
	%How long until mob can hit again
	hittimer : real4
	%How fast the mob can move
	movespeed : real4
	%Leg pivot point
	legpivotx : real4
    end record
%Array of inventory recipes
var recipesinvent : flexible array 1 .. 0 of array 1 .. 2 of array 1 .. 2 of item
%Array of the outputs of the niventory recipes
var outputsinvent : flexible array 1 .. 0 of item
%The font used to draw the FPS counter, done here so its not recreated every frame.
var FPSfont : int := Font.New ("Impact:16")
%Stream Number
var stream : int
%Opens the file which contains all inventory recipes. Notch, take notes.
open : stream, "datafiles/Recipes2x2.txt", get
%Loops through the files and stores all recipes in the arrays.
loop
    %Stop checking for recipes once the end of the file is reached
    exit when eof (stream)
    %This could have been better named, but it is a temporary variable used for manipulating, stores part of the recipe and then sorts them into the array
    var temp1 : string := ""
    %Expands the array to fit the new recipe
    new recipesinvent, upper (recipesinvent) + 1
    new outputsinvent, upper (outputsinvent) + 1
    %Gets the first row of items
    get : stream, temp1
    %Stores the first 2 numbers as the first item, second 2 as the second item, both on the first row
    recipesinvent (upper (recipesinvent)) (1) (1).id := strint (temp1 (1 .. 2))
    recipesinvent (upper (recipesinvent)) (1) (2).id := strint (temp1 (3 .. 4))
    %Gets the second row of items
    get : stream, temp1
    %Stores the first 2 numbers as the first item, second 2 as the second item, both on the first row
    recipesinvent (upper (recipesinvent)) (2) (1).id := strint (temp1 (1 .. 2))
    recipesinvent (upper (recipesinvent)) (2) (2).id := strint (temp1 (3 .. 4))
    %Gets the id and amount of the output and inserts directly into the outputs array
    get : stream, outputsinvent (upper (outputsinvent)).id
    get : stream, outputsinvent (upper (outputsinvent)).amount
end loop
%Closes to prevent errors and as good cleanup
close : stream
%Crafting table recipes, same as the inventory except have an extra row and column
var recipes : flexible array 1 .. 0 of array 1 .. 3 of array 1 .. 3 of item
%Crafting table outputs
var outputs : flexible array 1 .. 0 of item
%Opens the file which contains crafting recipes
open : stream, "datafiles/Recipes.txt", get
%Loops through the files and stores all recipes in the arrays.
loop
    %Stop checking for recipes once the end of the file is reached
    exit when eof (stream)
    %This could have been better named, but it is a temporary variable used for manipulating, stores part of the recipe and then sorts them into the array
    var temp : string := ""
    %Expands the array to fit the new recipe
    new recipes, upper (recipes) + 1
    new outputs, upper (outputs) + 1
    %Gets the First row of items
    get : stream, temp
    %Stores the first 2 numbers as the first item, second 2 as the second item, third 2 as the third item, all on the first row
    recipes (upper (recipes)) (1) (1).id := strint (temp (1 .. 2))
    recipes (upper (recipes)) (1) (2).id := strint (temp (3 .. 4))
    recipes (upper (recipes)) (1) (3).id := strint (temp (5 .. 6))
    %Gets the Second row of items
    get : stream, temp
    %Stores the first 2 numbers as the first item, second 2 as the second item, third 2 as the third item, all on the second row
    recipes (upper (recipes)) (2) (1).id := strint (temp (1 .. 2))
    recipes (upper (recipes)) (2) (2).id := strint (temp (3 .. 4))
    recipes (upper (recipes)) (2) (3).id := strint (temp (5 .. 6))
    %Gets the Third row of items
    get : stream, temp
    %Stores the first 2 numbers as the first item, second 2 as the second item, third 2 as the third item, all on the third row
    recipes (upper (recipes)) (3) (1).id := strint (temp (1 .. 2))
    recipes (upper (recipes)) (3) (2).id := strint (temp (3 .. 4))
    recipes (upper (recipes)) (3) (3).id := strint (temp (5 .. 6))
    %Gets the id and amount of the output and inserts directly into the outputs array
    get : stream, outputs (upper (outputs)).id
    get : stream, outputs (upper (outputs)).amount
end loop
%Closes to prevent errors and as good cleanup
close : stream
%Imports the functions/procedures for the inventory and crafting tables
include "include/inventcrafting.t"
include "include/craftingtable.t"
%Opens the main game window
var window : int := Window.Open ("graphics:801;641, offscreenonly, title: 2D-Craft")
% Saves the root directory of the program for later uses
var maindirectory : string := Dir.Current
%These 4 are used for sectioning the screen for increased performance, but it looks terrible so its not used.
var sectionPart : int := 1
var low : int
var high : int
var updatePart : int := 0
% Loads images
var terrain : int := Pic.FileNew ("images/terrain.gif")
var terrainmodified : int := Pic.FileNew ("images/modifiedterrain.bmp")
var items : int := Pic.FileNew ("images/items.gif")
var fullheart : int := Pic.FileNew ("images/full-heart.gif")
var halfheart : int := Pic.FileNew ("images/half-heart.gif")
var mobfire : int := Pic.FileNew ("images/fire.gif")
var inventoryscreen : int := Pic.FileNew ("images/inventory.gif")
var craftingscreen : int := Pic.FileNew ("images/crafting.gif")
var background : int := Pic.FileNew ("images/Sky.gif")
% Draws texture pack
Pic.Draw (terrain, 0, 0, picCopy)
%Array of breaking animation frames
var breakinganimations : array 0 .. 9 of int
%2D array of textures, 11 light levels for each texture.
var textures : array 1 .. 256 of array 0 .. 10 of int4
%Miniature textures of the above
var smalltextures : array 1 .. 256 of int4
%Array of block information
var blockinfos : array 0 .. 256 of blockinfo
%Store the breaking animation frames into the appropriate variables
for i : 0 .. 9
    breakinganimations (i) := Pic.New (16 * i, 0, 16 * i + 15, 15)
end for
%Clear the screen for drawing the next image.
cls
%Draw the modified terrain pack containing the all blocks with all light levels, the smaller versions, and the items.
Pic.Draw (terrainmodified, 0, 0, picCopy)
%Air doesnt have a name as it doesn't actually ever get drawn/shown to exist
blockinfos (0).name := ""
blockinfos (0).tool := false
%Opens the file which contains block information
open : stream, "datafiles/blocks.txt", get
%Temporary storage variables
var tooltyperequired, tool, hardness2, weakness, name, id, nums : string
var num : int
%Array for the 2 blocks of the door in open position(Texture looks as if it were to be open, but since movement is sideways not back/forward, its closed)
var opendoortextures : array 1 .. 2 of array 0 .. 10 of int
%Amount of blocks, this will be incremente4d accordingly
var numblocks : int := 0
% Loops through each block in the file
loop
    %Stops looking for blocks once end of file is reached
    exit when eof (stream)
    %This number represents which block it is in relation to the txt file and the texture pack.
    get : stream, nums : *
    %Temporary variable to bypass unneccessary lines
    var temp : string := ""
    %Temporary variable for manipulating the string to extract the number
    var numtemp : string := ""
    %Transfers the string to the temporary variable excluding the *s
    for i : 1 .. length (nums)
	if nums (i) not= "*" then
	    numtemp += nums (i)
	end if
    end for
    %Converts the string to an int and stores it in the Final temporary variable
    num := strint (numtemp)
    %Reads in the id into its variable
    get : stream, id : *
    %Removes the prefixing identifier from the string
    id := id (6 .. length (id))
    %Skips the next 2 lines(x, y) as they are irrevelant in this(used for texturepack creation)
    get : stream, temp : *
    get : stream, temp : *
    %Reads in the name
    get : stream, name : *
    name := name (8 .. length (name))
    %Reads in the hardness
    get : stream, hardness2 : *
    hardness2 := hardness2 (12 .. length (hardness2))
    %Reads in the weakness
    get : stream, weakness : *
    weakness := weakness (12 .. length (weakness))
    %Reads in the tooltyperequired boolean
    get : stream, tooltyperequired : *
    tooltyperequired := tooltyperequired (20 .. length (tooltyperequired))
    %Reads in the tool boolean
    get : stream, tool : *
    tool := tool (8 .. length (tool))
    %Loops through the light levels
    for i : 0 .. 10
	%Creates a picture of the block at the current light level
	textures (strint (id)) (i) := Pic.New (i * 16, num * 16 - 16, i * 16 + 15, num * 16 - 1)
	%If the block is a door block, it also makes an image of the left 3 pixels for the open door image
	if name = "DoorBottom" then
	    opendoortextures (1) (i) := Pic.New (i * 16, num * 16 - 16, i * 16 + 2, num * 16 - 1)
	elsif name = "DoorTop" then
	    opendoortextures (2) (i) := Pic.New (i * 16, num * 16 - 16, i * 16 + 2, num * 16 - 1)
	end if
    end for
    %Stores the miniblock texture in its appropriate position in the smalltextures array
    smalltextures (strint (id)) := Pic.New (180, num * 16 - 16, 180 + 11, num * 16 - 5)
    %Transfers the read-in variables to their appropriate blockinfo
    blockinfos (strint (id)).name := name
    blockinfos (strint (id)).hardness := strint (hardness2)
    blockinfos (strint (id)).weakness := strint (weakness)
    if tooltyperequired = "true" then
	blockinfos (strint (id)).tooltyperequired := true
    else
	blockinfos (strint (id)).tooltyperequired := false
    end if
    if tool = "true" then
	blockinfos (strint (id)).tool := true
    else
	blockinfos (strint (id)).tool := false
    end if
    %Increments the amount of blocks for use in obtaining the items textures
    numblocks += 1
end loop
%Opens the tools(Items) file for reading
open : stream, "datafiles/tools.txt", get
%More temporary variables
var strength, durability, tooltype, placable : string
%Arrays for the num and id of the items for use in a later for loop to retrieve the textures
var numsarray : flexible array 1 .. 0 of int
var numsids : flexible array 1 .. 0 of int
%Loops through the items file to retrieve item information
loop
    %Stops reading at the end of the file
    exit when eof (stream)
    %Reads in the num variable
    get : stream, nums : *
    %Temporary variable for skipping unneccessary varibale in the text file
    var temp : string := ""
    %Temporary variable for manipulating the number
    var numtemp : string := ""
    %Loops through the string and transfers everything but the '*'s
    for i : 1 .. length (nums)
	if nums (i) not= "*" then
	    numtemp += nums (i)
	end if
    end for
    %Converts it to an int and reassigns it to the final temp variable
    num := strint (numtemp)
    %Reads in the id variable
    get : stream, id : *
    id := id (6 .. length (id))
    %Creates a new array index for the num and id values
    new numsarray, upper (numsarray) + 1
    new numsids, upper (numsids) + 1
    %Stores them in the new indexes
    numsarray (upper (numsarray)) := num
    numsids (upper (numsids)) := strint (id)
    %Skips the next 2 lines(x, y) as they are irrevelant in this(used for texturepack creation)
    get : stream, temp : *
    get : stream, temp : *
    %Reads in the name
    get : stream, name : *
    name := name (8 .. length (name))
    %Reads in the strength
    get : stream, strength : *
    strength := strength (12 .. length (strength))
    %Reads in the tooltype
    get : stream, tooltype : *
    tooltype := tooltype (12 .. length (tooltype))
    %Reads in the tool boolean
    get : stream, tool : *
    tool := tool (8 .. length (tool))
    %Reads in the durability and placable variables
    get : stream, durability : *
    get : stream, placable : *
    placable := placable (12 .. length (placable))
    durability := durability (14 .. length (durability))
    %Assigns these variables to their appropriate blockinfos
    blockinfos (strint (id)).name := name
    blockinfos (strint (id)).strength := strint (strength)
    blockinfos (strint (id)).tooltype := strint (tooltype)
    blockinfos (strint (id)).durability := strint (durability)
    blockinfos (strint (id)).placable := strint (placable)
    if tool = "true" then
	blockinfos (strint (id)).tool := true
    else
	blockinfos (strint (id)).tool := false
    end if
end loop
%Creates a variable for the amount of items to make code slightly more easily read
var amountofitems : int := upper (numsarray)
%Loops through each column
for i : 1 .. 12
    %Loops trough each row
    for j : 1 .. 2
	%If the block being stored is actually stsill a block then create the image
	if j * 12 - 12 + i <= amountofitems then
	    %Creates the image from the texture pack image
	    textures (numsids (j * 12 - 12 + i)) (0) := Pic.New (i * 16 - 16, numblocks * 16 + j * 16 - 16, i * 16 - 1, numblocks * 16 + j * 16 - 1)
	    %Mirrors it to make it look better when held in the characters hand
	    textures (numsids (j * 12 - 12 + i)) (0) := Pic.Mirror (textures (numsids (j * 12 - 12 + i)) (0))
	end if
    end for
end for
%Clears the screen for the next image
cls
%Creates an array for the block entity textures
var blockEntityImages : array 1 .. upper (textures) of int
% Loops through the block entities
for i : 1 .. upper (blockEntityImages)
    %If the index belongs to an existant block then create a scale image of the full scale image
    if textures (i) (0) > 0 then
	blockEntityImages (i) := Pic.Scale (textures (i) (0), 8, 8)
    end if
end for
%Loads in the character image
var playerskin : int := Pic.FileNew ("images/char.gif")
%Draws the character skin
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
%Loads in the zombie image
var zombieskin : int := Pic.FileNew ("images/zombie.gif")
%Draws the zombie skin
Pic.Draw (zombieskin, 0, 0, picMerge)
%Creates base images
var zombierightleg : int := Pic.New (0, 0, 3, 11)
var zombieleftleg : int := Pic.New (8, 0, 11, 11)
var zombierightarm : int := Pic.New (40, 0, 43, 11)
var zombieleftarm : int := Pic.New (48, 0, 51, 11)
var zombierightbody : int := Pic.New (16, 0, 19, 11)
var zombieleftbody : int := Pic.New (28, 0, 31, 11)
var zombierighthead : int := Pic.New (0, 16, 7, 23)
var zombielefthead : int := Pic.New (16, 16, 23, 23)
cls
% Recreates the moving parts, but with whitespace around them to allow for easier rotation.
Pic.Draw (zombierightarm, 50, 50, picMerge)
Pic.Free (zombierightarm)
zombierightarm := Pic.New (37, 45, 66, 76)
cls
Pic.Draw (zombieleftarm, 50, 50, picMerge)
Pic.Free (zombieleftarm)
zombieleftarm := Pic.New (37, 45, 66, 76)
cls
Pic.Draw (zombierightleg, 50, 50, picMerge)
Pic.Free (zombierightleg)
zombierightleg := Pic.New (37, 45, 66, 76)
cls
Pic.Draw (zombieleftleg, 50, 50, picMerge)
Pic.Free (zombieleftleg)
zombieleftleg := Pic.New (37, 45, 66, 76)
cls
Pic.Draw (zombierighthead, 50, 50, picMerge)
Pic.Free (zombierighthead)
zombierighthead := Pic.New (42, 38, 57, 66)
cls
Pic.Draw (zombielefthead, 50, 50, picMerge)
Pic.Free (zombielefthead)
zombielefthead := Pic.New (42, 38, 57, 66)
cls
%Variables for Player Model Drawing
%Mouse input variables
var mx, my, mbutton : int
%The x position theat represents the middle of the screen
var middlex : int := round (maxx / 2) + 4
%The y position that represents the middle of the screen
var middleyorig : int := round (maxy / 2)
%The y position adjusted for bobbing
var middley : int := middleyorig
%The point in which the had and the arm pivot around
var armheadpivotyorig : int := middley + 24
%A modifiable pivot point
var armheadpivoty : int := armheadpivotyorig
%The angle at which the arm is rotating
var armangle : real
%The variables for the modified body parts
var rightarmmod : int
var leftarmmod : int
var rightheadmod : int
var leftheadmod : int
var rightlegmod : int
var leftlegmod : int
%Which way the character is looking, 1 is right 0 is left
var facingdirection : int := 1
%The point at which the player is at, this is equal to positionx but is used for simplicity
var playerx : int := 0
%Which way the player is moving, 1 is right 0 is left
var movingdirection : int := 0
%The position in which the leg is pivoting on the ground
var legpivotx : int := 0
%Prevents legs from going into the splits
const maxlegangle : int := 45
%var timecntr : int := 0
%This is used to prevent wierd arm spasms
var lastarmpos : real := 90
%Which direction the arm was moving the previous frame
var lastarmswing : string := "right"
%Which direction the arm is moving the current frame
var armswing : string := "right"
%Set to true when the arm swing direction is changed
var armswingchange := false
% Creates the record that will hold information about a specific block
type block :
    record
	%Id of the block
	blockid : int4
	%Brightness level of the block
	lightlevel : int4
	%This variable is used when the block is a door, specifes whether its open or closed
	dooropen : int4
    end record
% Creates the record that holds the blocks in a chunk
type chunk :
    record
	%Array of all the blocks in the chunk
	blocks : array 0 .. 31 of array 1 .. 128 of block
	%Boolean(acts as one) variable to tell whether the chunk has been lit yet or not
	lighted : int4
	%Which region is it(Example: Forest, plains, desert)
	biome : int4
	%Which day/night stage the chunk is in
	day : int4
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
if File.Exists ("datafiles/controls") then
    % Opens the controls file and loads the key configuration. Since we are assigning the values to characters we get new line characters between controls so we need to skip them.
    open : stream, "datafiles/controls", get
    get : stream, leftkey
    get : stream, temp
    get : stream, rightkey
    get : stream, temp
    get : stream, jumpkey
    % Closes file to prevent errors
    close : stream
end if
%Array of menu messages (Things below the title)
var menumessages : flexible array 1 .. 0 of string
%Verifies the user is in the main directory
Dir.Change (maindirectory)
%If the user hasn't deleted the file then load in all the menu messages.
if File.Exists ("datafiles/menumessages") then
    open : stream, "datafiles/menumessages", get
    loop
	exit when eof (stream)
	new menumessages, upper (menumessages) + 1
	get : stream, menumessages (upper (menumessages)) : *
    end loop
    %If the user has deleted the file then they clearly don't want any menumessages, so don't give it to them.
else
    new menumessages, upper (menumessages) + 1
    menumessages (upper (menumessages)) := " "
end if
% Allocates 11 chunk slots.
var chunks : array 0 .. 10 of chunk
%Array of enemies
var mobs : flexible array 1 .. 0 of mobentity
%Array of block entities
var blockentities : array 1 .. 1000 of blockentity
%The next entity to be edited
var nextentity : int4 := 1
%Counts The time that has passed for counting of block despawn ticks
var blocktimer : int4
%How many seconds between ticks
const blockupdatetimers : int := 5
%How many seconds from creation until a block gets destroyed. Prevents lag from existing blocks.
const blockdespawntime : int := 300
% Generates a random seed to be used if a new map is generated, this will be reassigned if loading a map
var seed : int := Rand.Int (-1073741824, 1073741824)
%Counter for time of day
var ingametime : real := 0
%Day Time
var daytime : boolean := true
% X position of the players character
var positionx : int := 0
%Used for smoother movement and making sure that different FPS give teh same movement speed
var positionxreal : real := 0
%The x and y of the players spawnpoint
var spawnpointx : int := 0
var spawnpointy : int := 64
% Specifies the actual chunk index of the first chunk in the "chunks" array
var base : int := floor (positionx / 16 / 32) - 5
% Y position of the players character
var positiony : real := 64 * 16
% Creates the inventory and sets every slot to air
var inventory : array 1 .. 36 of item
for i : 1 .. 36
    inventory (i).id := 0
    inventory (i).amount := 0
end for
%Creates the inventory table and sets every slot to air
var table : array 1 .. 2 of array 1 .. 2 of item
for i : 1 .. 2
    for j : 1 .. 2
	table (i) (j).id := 0
	table (i) (j).amount := 0
    end for
end for
%Creates the crafting table and sets every slot to air
var craftingtable : array 1 .. 3 of array 1 .. 3 of item
for i : 1 .. 3
    for j : 1 .. 3
	craftingtable (i) (j).id := 0
	craftingtable (i) (j).amount := 0
    end for
end for
% Specifies the players health, it is set to 20 by default (10 hearts) and is re-assigned if loading an existing map
var playerhealth : int := 20
% Creates the variable that holds accumulative falling damage
var damage : real := 0
%How long a block has been being broken for
var breaktimer : int := 0
%Which stage in the animation is it at(-1 is not being broken)
var breakstage : int := -1
%The x and y position of the block being broken
var breakingblockx : int := 0
var breakingblocky : int := 0
%The block being broken's hardness
var hardness : int := 0
%Accumulative time counter
var timeframe : int := 0
%Timer for ticks
var tickTime : int := 0
%How many milliseconds between ticks
var tickLength : int := 2000
%Used to exit the menu
var quitbool : boolean := false
%Called when damage is taken, plays sound
procedure playsoundeffect (name : string)
    Dir.Change (maindirectory)
    Music.PlayFileReturn ("sounds/" + name)
end playsoundeffect
%Array of light sources(Torches)
%X positions
var lightsourcesx : flexible array 1 .. 0 of int
%Y positions
var lightsourcesy : flexible array 1 .. 0 of int
%Chunk index
var lightsourcechunk : flexible array 1 .. 0 of int
%The light levels of the blocks surrounding the block being updated
var right, left, up, down, newlight : int
% Prevents multiples of a torch
var flag : int := 0
%Procedure to update a blocks light level
procedure updateBlock (id, i, j : int)
    var baselight : int := 0
    if daytime not= true then
	baselight := 5
    end if
    %Whether the block is affected by sunlight or not
    var sunlight : boolean := true
    %Loops through all the blocks directly above the block
    for decreasing h : 128 .. j + 1
	%If the block is a solid block then sunlight is not affecting the block being updated
	if chunks (id - base).blocks (i) (h).blockid not= 0 and chunks (id - base).blocks (i) (h).blockid not= 15 then
	    sunlight := false
	end if
    end for
    %If the block is being affected by sunlight and is an air block than continue the lightlevel of 0 along
    if sunlight and chunks (id - base).blocks (i) (j).blockid = 0 then
	chunks (id - base).blocks (i) (j).lightlevel := baselight
    else
	%Sets the up and down to the light levels above and below the block, prevents error by setting blocks above and below to light level 10
	if j < 128 then
	    up := chunks (id - base).blocks (i) (j + 1).lightlevel
	else
	    up := 10
	end if
	if j > 1 then
	    down := chunks (id - base).blocks (i) (j - 1).lightlevel
	else
	    down := 10
	end if
	%Sets the right to the light level to the right, if the right is another chunk then make it that light level, if the right isnt a chunk then set it to 10
	if i < 31 then
	    right := chunks (id - base).blocks (i + 1) (j).lightlevel
	else
	    if id - base + 1 < 10 then
		if chunks (id - base + 1).lighted = 1 then
		    right := chunks (id - base + 1).blocks (0) (j).lightlevel
		else
		    right := 10
		end if
	    else
		right := 10
	    end if
	end if
	%Sets the left to the light level to the left, if the left is another chunk then make it that light level, if the left isnt a chunk then set it to 10
	if i > 0 then
	    left := chunks (id - base).blocks (i - 1) (j).lightlevel
	else
	    if id - base > 0 then
		if chunks (id - base - 1).lighted = 1 then
		    left := chunks (id - base - 1).blocks (31) (j).lightlevel
		else
		    left := 10
		end if
	    else
		left := 10
	    end if
	end if
	%The variable that controls the new light level of the block
	newlight := 10
	%Sets the light level to the lowest adjacent light level
	if up < newlight then
	    newlight := up
	end if
	if down < newlight then
	    newlight := down
	end if
	if right < newlight then
	    newlight := right
	end if
	if left < newlight then
	    newlight := left
	end if
	%Increments by 1 to make it slightly darker
	newlight += 1
	%Sets the block to the new light level
	chunks (id - base).blocks (i) (j).lightlevel := newlight
	%Makes sure the light level is under 11
	if chunks (id - base).blocks (i) (j).lightlevel > 10 then
	    chunks (id - base).blocks (i) (j).lightlevel := 10
	end if
	%If the block is a torch
	if chunks (id - base).blocks (i) (j).blockid = 15 then
	    %Prevents multiple torch variables
	    if upper (lightsourcesx) not= 0 then
		if lightsourcesx (upper (lightsourcesx)) = i and lightsourcesy (upper (lightsourcesy)) = j then
		    flag := 1
		end if
	    end if
	    %Sets the torches light level to 1 and creates a new light source at the position of the torch
	    if flag not= 1 then
		chunks (id - base).blocks (i) (j).lightlevel := 1
		new lightsourcesx, upper (lightsourcesx) + 1
		new lightsourcesy, upper (lightsourcesy) + 1
		new lightsourcechunk, upper (lightsourcechunk) + 1
		lightsourcesx (upper (lightsourcesx)) := i
		lightsourcesy (upper (lightsourcesy)) := j
		lightsourcechunk (upper (lightsourcechunk)) := id
	    end if
	    flag := 0
	end if
    end if
end updateBlock
%Updated x and y coords
var chunk1, l, m : int
%Used to calculate the light level of a certain block
var d, e : int
%Updates lighting around a certain block
procedure updateLighting (id, i, j : int)
    %Resets the light sources arrays
    new lightsourcesx, 0
    new lightsourcesy, 0
    new lightsourcechunk, 0
    %Resets all potentially effected blocks light levels
    for a : 0 .. 20
	for decreasing b : j + 10 .. 1
	    if b < 129 and b > 0 then
		if i - 10 + a < 0 then
		    chunks (id - 1 - base).blocks (32 + (i - 10 + a)) (b).lightlevel := 10
		elsif i - 10 + a > 31 then
		    chunks (id + 1 - base).blocks ((i - 10 + a) - 32) (b).lightlevel := 10
		else
		    chunks (id - base).blocks (i - 10 + a) (b).lightlevel := 10
		end if
	    end if
	end for
    end for
    %Updates all potentially affected blocks
    for a : 0 .. 20
	for decreasing b : j + 10 .. 1
	    if b < 129 and b > 0 then
		if i - 10 + a < 0 then
		    updateBlock (id - 1, 32 + (i - 10 + a), b)
		elsif i - 10 + a > 31 then
		    updateBlock (id + 1, (i - 10 + a) - 32, b)
		else
		    updateBlock (id, i - 10 + a, b)
		end if
	    end if
	end for
    end for
    %Reupdates them going the other direction to verify success
    for decreasing a : 20 .. 0
	for decreasing b : j + 10 .. 1
	    if b < 129 and b > 0 then
		if i - 10 + a < 0 then
		    updateBlock (id - 1, 32 + (i - 10 + a), b)
		elsif i - 10 + a > 31 then
		    updateBlock (id + 1, (i - 10 + a) - 32, b)
		else
		    updateBlock (id, i - 10 + a, b)
		end if
	    end if
	end for
    end for
    %If there is torches around
    if upper (lightsourcesx) not= 0 then
	%Loops through the torches
	for a : 1 .. upper (lightsourcesx)
	    %Loops through the surrounding blocks
	    for b : lightsourcesx (a) - 10 .. lightsourcesx (a) + 10
		for c : lightsourcesy (a) - 10 .. lightsourcesy (a) + 10
		    %d is x distance from torch, e is y
		    d := abs (lightsourcesx (a) - b)
		    e := abs (lightsourcesy (a) - c)
		    %The new light level is the 2 added together
		    var targetlightlevel : int := d + e
		    %Prevents the light level from going about 10 or under 0
		    if targetlightlevel > 10 then
			targetlightlevel := 10
		    end if
		    if targetlightlevel < 0 then
			targetlightlevel := 0
		    end if
		    %Sets the temporary x and y variables to the chunk, x, and y of the block being updated
		    if b < 0 then
			chunk1 := lightsourcechunk (a) - 1 - base
			l := 32 + b
			m := c
		    elsif b > 31 then
			chunk1 := lightsourcechunk (a) + 1 - base
			l := b - 32
			m := c
		    else
			chunk1 := lightsourcechunk (a) - base
			l := b
			m := c
		    end if
		    %Makes sure the y position is in bounds
		    if m < 1 then
			m := 1
		    end if
		    if m > 128 then
			m := 128
		    end if
		    %Sets the light level to one just calculated
		    if chunks (chunk1).blocks (l) (m).lightlevel > targetlightlevel then
			chunks (chunk1).blocks (l) (m).lightlevel := targetlightlevel
		    end if
		end for
	    end for
	end for
    end if
end updateLighting
%Generates a chunk
procedure createChunk (id : int)
    % Adds the chunk index to the seed so that the chunk will generate the same no matter how many chunks have been loaded prior
    Rand.Set (seed + id - 1)
    var leftbiome : int := Rand.Int (1, 2)
    Rand.Set (seed + id)
    %Sets all blocks to air
    for i : 0 .. 31
	for j : 1 .. 128
	    chunks (id - base).blocks (i) (j).blockid := 0
	end for
    end for
    if Rand.Int (1, 100) > 75 then
	chunks (id - base).biome := leftbiome
    else
	chunks (id - base).biome := Rand.Int (1, 2)
    end if
    %Variables to control the terrain
    var frequency : real := 64
    var amplitude : real := 1
    var persistence : real := 2
    %Holds the y positions of all 6 passes
    var heights : array 0 .. 5 of array 0 .. 31 of real
    %Final y positions
    var finalheights : array 0 .. 31 of real
    %For all 6 passes
    for cnt : 0 .. 5
	%Te frequency get lower over passes and amplitude gets larger
	frequency /= 2
	amplitude := persistence ** cnt
	%Sets all the y vaules to 63
	for i : 0 .. 31
	    heights (cnt) (i) := 63
	end for
	%What height value is being started at
	var heightvalue : int := 63
	%What direction to generate in
	var direction : string := "right"
	%Checks the left and right chunks and sets the y value of the current chunk to the edge y of the adjacent chunk to create a smooth transition
	if id - 1 - base > -1 then
	    if chunks (id - 1 - base).lighted = 1 then
		for decreasing i : 128 .. 1
		    if chunks (id - 1 - base).blocks (31) (i).blockid = 4 then
			heightvalue := i
			exit
		    end if
		end for
	    end if
	end if
	if id + 1 - base < 11 then
	    if chunks (id + 1 - base).lighted = 1 then
		direction := "left"
		for decreasing i : 128 .. 1
		    if chunks (id + 1 - base).blocks (0) (i).blockid = 4 then
			heightvalue := i
			exit
		    end if
		end for
	    end if
	end if
	%Sets the y value of the edge x to the one on the base height value
	for i : 0 .. 5
	    if direction = "right" then
		heights (i) (0) := heightvalue
	    else
		heights (i) (31) := heightvalue
	    end if
	end for
	%Loops through rightwards if the direction is right, otherwise it goes left
	if direction = "right" then
	    %Loops through the x values by the frequency variable
	    for i : 1 .. 31 by round (frequency)
		%Sets the number to a 1d perlin noise value
		heights (cnt) (i) := heights (cnt) (i - 1) + (Rand.Real * 2 - 1) * persistence
		%Sets all the y vlues inbetween to the one just generated to create flat spots
		for j : 1 .. round (frequency) - 1
		    if i + j < 32 then
			heights (cnt) (i + j) := heights (cnt) (i)
		    end if
		end for
	    end for
	    %Loops through all the x values to smooth them
	    for i : 0 .. 31 by round (frequency)
		for j : 1 .. round (frequency) - 2
		    if i + j < 32 then
			if i + round (frequency) < 32 then
			    heights (cnt) (i + j) := heights (cnt) (i) + ((heights (cnt) (i + round (frequency)) - heights (cnt) (i)) / frequency) * j
			else
			    heights (cnt) (i + j) := heights (cnt) (i) + ((heights (cnt) (31) - heights (cnt) (i)) / frequency) * j
			end if
		    end if
		end for
	    end for
	    %Does the same for left direction except it reverses the direction
	else
	    for decreasing i : 30 .. 0 by round (frequency)
		heights (cnt) (i) := heights (cnt) (i + 1) + (Rand.Real * 2 - 1) * persistence
		for j : 1 .. round (frequency) - 1
		    if i - j > -1 then
			heights (cnt) (i - j) := heights (cnt) (i)
		    end if
		end for
	    end for
	    for decreasing i : 31 .. 0 by round (frequency)
		for j : 1 .. round (frequency) - 2
		    if i - j > -1 then
			if i - round (frequency) > -1 then
			    heights (cnt) (i - j) := heights (cnt) (i) + ((heights (cnt) (i - round (frequency)) - heights (cnt) (i)) / frequency) * j
			else
			    heights (cnt) (i - j) := heights (cnt) (i) + ((heights (cnt) (0) - heights (cnt) (i)) / frequency) * j
			end if
		    end if
		end for
	    end for
	end if
    end for
    %Sets the finalheights to the average of all 6 passes
    for i : 0 .. 31
	finalheights (i) := round ((heights (0) (i) + heights (1) (i) + heights (2) (i) + heights (3) (i) + heights (4) (i) + heights (5) (i)) / 6)
    end for
    %If the 2 blocks to the side have the same y values, then the current one has the same value to prevent random blocks poking out
    for i : 1 .. 30
	if finalheights (i - 1) = finalheights (i + 1) then
	    finalheights (i) := finalheights (i - 1)
	end if
    end for
    %Sets the block to be bedrock, this is just a placeholder
    for i : 0 .. 31
	chunks (id - base).blocks (i) (round (finalheights (i))).blockid := 1
    end for
    % Loops through every column in the map
    for i : 0 .. 31
	%The height of the ground
	var groundheight : int := 64
	%Loops through the y values until bedrock is found, this is the groundheight
	for decreasing j : 128 .. 1
	    if chunks (id - base).blocks (i) (j).blockid = 1 then
		groundheight := j
		exit
	    end if
	end for
	% Assigns air to all sky blocks
	for j : groundheight + 1 .. 128
	    chunks (id - base).blocks (i) (j).blockid := 0
	end for
	%IF the biome is forest
	if chunks (id - base).biome = 1 then
	    % Assigns grass to the top layer of dirt
	    chunks (id - base).blocks (i) (groundheight).blockid := 4
	    % Assigns the top 4 layers of ground to be dirt (Minus the layer of grass above)
	    for j : groundheight - 4 .. groundheight - 1
		chunks (id - base).blocks (i) (j).blockid := 3
	    end for
	    %If the biome is desert
	elsif chunks (id - base).biome = 2 then
	    % Assigns sand to the top 3 layer of sand
	    for j : groundheight - 2 .. groundheight
		chunks (id - base).blocks (i) (j).blockid := 25
	    end for
	    % Assigns the top 2 layers of ground to be sand (Minus the 3 layers of sand above)
	    for j : groundheight - 4 .. groundheight - 3
		chunks (id - base).blocks (i) (j).blockid := 26
	    end for
	end if
	% Assigns Everything below grass and above bedrock to stone
	for j : 6 .. groundheight - 5
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
				if finalheights (i + k - 1) - 5 > j + 1 - 1 then
				    chunks (id - base).blocks (i + k - 1) (j + l - 1).blockid := 9
				end if
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
				if finalheights (i + k - 1) - 5 > j + l - 1 then
				    chunks (id - base).blocks (i + k - 1) (j + l - 1).blockid := 7
				end if
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
				if finalheights (i + k - 1) - 5 > j + l - 1 then
				    chunks (id - base).blocks (i + k - 1) (j + l - 1).blockid := 8
				end if
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
				if finalheights (i + k - 1) - 5 > j + l - 1 then
				    chunks (id - base).blocks (i + k - 1) (j + l - 1).blockid := 10
				end if
			    end if
			end if
		    end for
		end for
	    end if
	end for
	if chunks (id - base).biome = 1 then
	    %4% chance of creating a tree
	    if Rand.Int (1, 50) <= 2 then
		%THe baseheight is the y we generated earlier
		var baseheight : int := round (finalheights (i))
		%The height of the trunk
		var trunk := Rand.Int (4, 6)
		%Width and height of the leaves
		var leaves := Rand.Int (1, 2) * 2 + 1
		%If the tree will stay in the chunk then
		if i - floor (leaves / 2) > -1 and i + ceil (leaves / 2) < 32 then
		    %Create the trunk
		    for j : 1 .. trunk
			chunks (id - base).blocks (i) (baseheight + j).blockid := 6
		    end for
		    %Creates the leaves
		    for j : 0 .. leaves - 1
			for k : 0 .. leaves - 1
			    chunks (id - base).blocks (i - floor (leaves / 2) + j) (baseheight + trunk - 2 + k).blockid := 16
			end for
		    end for
		end if
	    end if
	elsif chunks (id - base).biome = 2 then
	    %10% chance of creating a cactus
	    if Rand.Int (1, 100) <= 10 then
		%Height is how tall it is
		var height := Rand.Int (1, 4)
		%Base height is where the bottom is in y position
		var baseheight : int := round (finalheights (i))
		%Creates the blocks
		for j : 1 .. height
		    chunks (id - base).blocks (i) (baseheight + j).blockid := 27
		end for
	    end if
	end if
    end for
    if chunks (id - base).biome = 1 then
	%5% chance of creating a house in the chunk
	if Rand.Int (1, 100) <= 25 then
	    %Random house width
	    var housewidth : int := Rand.Int (7, 15)
	    %Makes sure the width of the hosue is an odd number so that the top doesnt end flat
	    if housewidth mod 2 = 0 then
		housewidth -= 1
	    end if
	    %Height of the hosue
	    var househeight : int := 5
	    %Left x position of the house
	    var startx : int := Rand.Int (1, 30 - housewidth)
	    %Bottom y of the house
	    var starty : int
	    %Sets the y value to the top layer of grass
	    for decreasing i : 128 .. 1
		if chunks (id - base).blocks (startx) (i).blockid = 4 then
		    starty := i
		    exit
		end if
	    end for
	    %Boolean for building, if this gets set to false then the house wont get built
	    var cleartobuild : boolean := true
	    %Checks all blocks in building vicinity to see if they are trees and will get in the way
	    for cnt : -1 .. housewidth
		for cnt2 : -1 .. househeight + floor (housewidth / 2)
		    if chunks (id - base).blocks (startx + cnt) (starty + cnt2).blockid = 6 or chunks (id - base).blocks (startx + cnt) (starty + cnt2).blockid = 16 then
			cleartobuild := false
		    end if
		end for
	    end for
	    %If there are no trees in the building vicinity then build the house
	    if cleartobuild then
		%Craetes the floor
		for i : 1 .. housewidth
		    chunks (id - base).blocks (startx + i - 1) (starty).blockid := 5
		end for
		%Sets all blocks inside the house to air
		for i : 1 .. housewidth - 1
		    for j : 1 .. househeight + floor (housewidth / 2)
			chunks (id - base).blocks (startx + i - 1) (starty + j).blockid := 0
		    end for
		end for
		%Creates the left wall
		for i : 1 .. househeight - 1
		    chunks (id - base).blocks (startx) (starty + i).blockid := 5
		end for
		%Creates a door on the left wall
		chunks (id - base).blocks (startx) (starty + 1).blockid := 18
		chunks (id - base).blocks (startx) (starty + 1).dooropen := 1
		chunks (id - base).blocks (startx) (starty + 2).blockid := 19
		chunks (id - base).blocks (startx) (starty + 2).dooropen := 1
		%Creates the right wall
		for i : 1 .. househeight - 1
		    chunks (id - base).blocks (startx + housewidth - 1) (starty + i).blockid := 5
		end for
		%Creates a door on the right wall
		chunks (id - base).blocks (startx + housewidth - 1) (starty + 1).blockid := 18
		chunks (id - base).blocks (startx + housewidth - 1) (starty + 1).dooropen := 1
		chunks (id - base).blocks (startx + housewidth - 1) (starty + 2).blockid := 19
		chunks (id - base).blocks (startx + housewidth - 1) (starty + 2).dooropen := 1
		%Creates the roof
		var roofy : int
		for i : 0 .. housewidth + 1
		    if i <= housewidth / 2 + 1 then
			roofy := starty + househeight + i - 1
		    else
			roofy -= 1
		    end if
		    chunks (id - base).blocks (startx + i - 1) (roofy).blockid := 6
		    for j : starty + househeight - 1 .. roofy - 1
			chunks (id - base).blocks (startx + i - 1) (j).blockid := 5
		    end for
		end for
	    end if
	end if
    end if
    %Sets all light levels to 10
    for i : 0 .. 31
	for decreasing j : 128 .. 1
	    chunks (id - base).blocks (i) (j).lightlevel := 10
	end for
    end for
    %Updates all blocks in both directions to create lighting
    for i : 0 .. 31
	for decreasing j : 128 .. 1
	    updateBlock (id, i, j)
	end for
    end for
    for decreasing i : 31 .. 0
	for decreasing j : 128 .. 1
	    updateBlock (id, i, j)
	end for
    end for
    %Marks the chunk as lighted
    chunks (id - base).lighted := 1
    if daytime then
	chunks (id - base).day := 1
    else
	chunks (id - base).day := 0
    end if
end createChunk
%Used to change day/night cycles
procedure changeCycle (day : boolean)
    var baselevel : int := 0
    if day not= true then
	baselevel := 3
    end if
    for chunk : 0 .. 10
	%Sets all light levels to 10
	for i : 0 .. 31
	    chunks (chunk).blocks (i) (128).lightlevel := baselevel
	    for decreasing j : 127 .. 1
		chunks (chunk).blocks (i) (j).lightlevel := 10
	    end for
	end for
    end for
    for chunk : 0 .. 10
	%Updates all blocks in both directions to create lighting
	for i : 0 .. 31
	    for decreasing j : 127 .. 1
		updateBlock (base + chunk, i, j)
	    end for
	end for
	for decreasing i : 31 .. 0
	    for decreasing j : 127 .. 1
		updateBlock (base + chunk, i, j)
	    end for
	end for
	if day = true then
	    chunks (chunk).day := 1
	else
	    chunks (chunk).day := 0
	end if
    end for
end changeCycle
% The procedure to load a chunk, requires the chunk id and the mapname to load from
procedure loadChunk (id : int, mapname : string)
    % Resets current directory to the root of the project
    Dir.Change (maindirectory)
    % Verifies that there is a saves folder, if there is not then it gets created
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
	open : stream, "blocks", get
	%Gets the current day/night state of the chunk so incase it is unloaded as night and loaded as day the chunk is updated accordingly
	get : stream, chunks (id - base).day
	% The file is arranged to read/write with a single block per 2 lines, they are ordered by x co-ordinate then by y co-ordinate
	for j : 0 .. 31
	    for k : 1 .. 128
		% Assigns the corresponding block to its place in the chunk
		get : stream, chunks (id - base).blocks (j) (k).blockid
		% Assigns the corresponding light level to the block in the chunk
		get : stream, chunks (id - base).blocks (j) (k).lightlevel
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
    open : stream, "blocks", put
    %Stores the current day/night state of the chunk so incase it is unloaded as night and loaded as day the chunk is updated accordingly
    put : stream, chunks (id - base).day
    % The file is arranged to read/write with a single block per 2 lines, they are ordered by x co-ordinate then by y co-ordinate
    for j : 0 .. 31
	for k : 1 .. 128
	    % Writes the current block
	    put : stream, chunks (id - base).blocks (j) (k).blockid
	    % Writes the light level
	    put : stream, chunks (id - base).blocks (j) (k).lightlevel
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
    open : stream, "level", put
    % Writes the seed, location, health and inventory into the file
    put : stream, seed
    put : stream, ingametime
    put : stream, positionx
    put : stream, positiony
    put : stream, spawnpointx
    put : stream, spawnpointy
    put : stream, playerhealth
    put : stream, damage
    for i : 1 .. 36
	put : stream, inventory (i).id
	put : stream, inventory (i).amount
    end for
    % Closes file to prevent errors
    close : stream
    %Saves all the block entities to the block entities file
    open : stream, "blockentities", put
    for i : 1 .. upper (blockentities)
	if blockentities (i).id not= 0 then
	    put : stream, blockentities (i).id
	    put : stream, blockentities (i).amount
	    put : stream, blockentities (i).durability
	    put : stream, blockentities (i).x
	    put : stream, blockentities (i).y
	end if
    end for
    % Closes file to prevent errors
    close : stream
    %Saves all the mob entities to the mob entities file
    open : stream, "mobentities", put
    for i : 1 .. upper (mobs)
	put : stream, mobs (i).idtype
	put : stream, mobs (i).health
	put : stream, mobs (i).x
	put : stream, mobs (i).y
	put : stream, mobs (i).yvelocity
	put : stream, mobs (i).damage
	put : stream, mobs (i).onfire
	put : stream, mobs (i).firestage
	put : stream, mobs (i).movespeed
    end for
    % Closes file to prevent errors
    close : stream
end saveGame
% the procedure to load a game
procedure loadGame (mapname : string)
    % Navigates to the root directory to locate the saved game properly
    Dir.Change (maindirectory)
    % In order to be able to load we already know that the saves and map folder exists so we can simply navigate to them
    Dir.Change (Dir.Current + "/saves")
    Dir.Change (Dir.Current + "/" + mapname)
    % Opens the level data file to retrieve the seed, location, health and inventory
    var stream : int
    open : stream, "level", get
    get : stream, seed
    get : stream, ingametime
    get : stream, positionxreal
    positionx := round (positionxreal)
    get : stream, positiony
    get : stream, spawnpointx
    get : stream, spawnpointy
    get : stream, playerhealth
    get : stream, damage
    for i : 1 .. 36
	get : stream, inventory (i).id
	get : stream, inventory (i).amount
    end for
    % Closes file to prevent errors
    close : stream
    %Loads all the block entities into the game
    var counter : int := 1
    open : stream, "blockentities", get
    loop
	exit when eof (stream)
	get : stream, blockentities (counter).id
	get : stream, blockentities (counter).amount
	get : stream, blockentities (counter).durability
	get : stream, blockentities (counter).x
	get : stream, blockentities (counter).y
	counter += 1
    end loop
    % Closes file to prevent errors
    close : stream
    open : stream, "mobentities", get
    loop
	exit when eof (stream)
	new mobs, upper (mobs) + 1
	get : stream, mobs (upper (mobs)).idtype
	get : stream, mobs (upper (mobs)).health
	get : stream, mobs (upper (mobs)).x
	get : stream, mobs (upper (mobs)).y
	get : stream, mobs (upper (mobs)).yvelocity
	get : stream, mobs (upper (mobs)).damage
	get : stream, mobs (upper (mobs)).onfire
	get : stream, mobs (upper (mobs)).firestage
	get : stream, mobs (upper (mobs)).movespeed
	mobs (upper (mobs)).legpivotx := mobs (upper (mobs)).x
    end loop
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
    %Sets the spawn
    for decreasing i : 128 .. 1
	if chunks (5).blocks (0) (i).blockid not= 0 then
	    spawnpointy := i + 1
	    exit
	end if
    end for
    %Sets the player to the spawnpoint
    positiony := spawnpointy * 16
    % Tells the game that the map is loaded and the menu can be closed
    playing := true
    % Uses GUI.Quit to tell the game that the map is ready to play
    GUI.Quit
end createMap
%Array of directiory names and number of directories in a directory
var directoryNames : flexible array 1 .. 0 of array 1 .. 1000 of string
var numDirectorys : flexible array 1 .. 0 of int4
%Deletes a folder, used to delete maps.
procedure deletefolder (path : string)
    %Unfortunately there isn't a function that deletes a folder with items in it so we have to create that ourselves
    %Creates a new directoryNames and numDirectorys array index
    new directoryNames, upper (directoryNames) + 1
    new numDirectorys, upper (numDirectorys) + 1
    %Resets the numDirectorys just created to 0
    numDirectorys (upper (numDirectorys)) := 0
    %Changes to the submitted path
    Dir.Change (path)
    %Opens the folder for retrieving file names
    var stream := Dir.Open (Dir.Current)
    %Loops through the file names
    loop
	%Retrieves the fileName
	var fileName := Dir.Get (stream)
	exit when fileName = ""
	View.Update
	%If the file is not a directory delete it
	if Dir.Exists (fileName) = false then
	    File.Delete (fileName)
	    %If the file is a directory
	elsif fileName not= "." and fileName not= ".." then
	    %Puts the directory name into the array and increments the number of directorys
	    directoryNames (upper (directoryNames)) (numDirectorys (upper (numDirectorys)) + 1) := fileName
	    numDirectorys (upper (numDirectorys)) += 1
	end if
    end loop
    %Closes the folder
    Dir.Close (stream)
    %Recursively deletes all the directorys in this folder
    for i : 1 .. numDirectorys (upper (numDirectorys))
	deletefolder (directoryNames (upper (directoryNames)) (i) + "/")
    end for
    %Shortens the arrays
    new directoryNames, upper (directoryNames) - 1
    new numDirectorys, upper (numDirectorys) - 1
    %Delete the current directory
    Dir.Delete (Dir.Current)
    %Navigate to the parent directory
    Dir.Change ("..")
end deletefolder
% Creates the mapname variable
var mapname : string
% Redirects to the main directory to ensure correct loading
Dir.Change (maindirectory)
% Loads the Menu Background
var MenuBG : int := Pic.FileNew ("images/MenuBG.gif")
Dir.Change (maindirectory)
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
%Variables to prevent doubleclicking/typing
var doorclick : boolean := false
var eheld : boolean := false
%Main program loop
loop
    % Redirects to main directory to prevent read errors
    Dir.Change (maindirectory)
    % Calls the main menu file to display the main menu
    include "include/mainmenu.t"
    %If the player has quit close the window and end the program
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
    %Sets the player and legpivot x values to the one of the player to prevent the splits
    playerx := round (positionxreal)
    legpivotx := round (positionxreal)
    %Prevent spamming of the attack button
    var attackdelay : real := 0
    % Creates the timer for the FPS counter
    var elapsedtime : int := Time.Elapsed
    % Creates the variable that represents the currently selected inventory item
    var currentblock := 1
    % Sets the horizontal movement speed
    const movespeed := 32
    % Creates the variables for drawing
    var leftblockx, rightblockx, bottomblocky, topblocky, xoffset, yoffset : int
    % Creates the variable that tells whether the user is on the ground or not
    var collision : boolean := true
    % Creates the variable that will hold the accumulated verticle velocity
    var yvelocity : real := 0
    % Creates the gravity and terminal velocity constants, these effect jump height and falling speed
    const gravity := -128
    const terminalvelocity := 256
    % Allows for right clicks and middle mouse clicks to be registered
    Mouse.ButtonChoose ("multibutton")
    %Main game loop
    loop
	% Records the users input
	Input.KeyDown (chars)
	Mouse.Where (x, y, button)
	% If the character is jumping and is on the ground then the yvelocity is set to be jumping and sets the collision (On ground) variable to false
	if chars (jumpkey) and collision then
	    collision := false
	    yvelocity := 72
	end if
	% If the player has not reached terminal velocity then add gravity to the players velocity
	if yvelocity > -terminalvelocity then
	    if timeframe < 500 then
		yvelocity += gravity * (timeframe / 1000)
	    end if
	    % If the are at or above terminal velocity limit the player to terminal velocity
	else
	    yvelocity := -terminalvelocity
	end if
	% If the player is on the falling portion of their jump add the velocity to the accumulative damage
	if yvelocity < 0 then
	    if timeframe < 500 then
		damage -= yvelocity * (timeframe / 1000)
	    end if
	end if
	% Set the collision (On ground) to false so the user cannot jump mid-air if he/she walks off a ledge
	collision := false
	% If the right side of the player or the left side of the player is on a block then
	if ((getblockfloor (positionx, floor (positiony + yvelocity * (timeframe / 1000))).blockid not= 0
		and getblockfloor (positionx, floor (positiony + yvelocity * (timeframe / 1000))).blockid not= 15)
		and ((getblockfloor (positionx, floor (positiony + yvelocity * (timeframe / 1000))).blockid = 18
		and getblockfloor (positionx, floor (positiony + yvelocity * (timeframe / 1000))).dooropen = 0) = false
		and (getblockfloor (positionx, floor (positiony + yvelocity * (timeframe / 1000))).blockid = 19
		and getblockfloor (positionx, floor (positiony + yvelocity * (timeframe / 1000))).dooropen = 0) = false))
		or ((getblockfloor (positionx + 7, floor (positiony + yvelocity * (timeframe / 1000))).blockid not= 0
		and getblockfloor (positionx + 7, floor (positiony + yvelocity * (timeframe / 1000))).blockid not= 15)
		and ((getblockfloor (positionx + 7, floor (positiony + yvelocity * (timeframe / 1000))).blockid = 18
		and getblockfloor (positionx + 7, floor (positiony + yvelocity * (timeframe / 1000))).dooropen = 0) = false
		and (getblockfloor (positionx + 7, floor (positiony + yvelocity * (timeframe / 1000))).blockid = 19
		and getblockfloor (positionx + 7, floor (positiony + yvelocity * (timeframe / 1000))).dooropen = 0) = false)) then
	    % Set the collison (On ground) to true
	    collision := true
	    % If the damage is greater than 64 (4 blocks fall) then subtract 4 blocks from the damage and subtract the damage from the players health
	    if damage > 64 then
		playsoundeffect ("hurt.wav")
		damage -= 64
		playerhealth -= floor (damage / 16)
	    end if
	    % Reset the damage and velocity variables for the next fall
	    damage := 0
	    yvelocity := 0
	    % Set the player onto the ground
	    positiony := floor (positiony / 16) * 16
	    %If the user has hit their head, drop their velocity to 0 so they begin falling again
	elsif ((getblockfloor (positionx, floor (positiony + yvelocity * (timeframe / 1000)) + 29).blockid not= 0
		and getblockfloor (positionx, floor (positiony + yvelocity * (timeframe / 1000)) + 29).blockid not= 15)
		and ((getblockfloor (positionx, floor (positiony + yvelocity * (timeframe / 1000)) + 29).blockid = 18
		and getblockfloor (positionx, floor (positiony + yvelocity * (timeframe / 1000)) + 29).dooropen = 0) = false
		and (getblockfloor (positionx, floor (positiony + yvelocity * (timeframe / 1000)) + 29).blockid = 19
		and getblockfloor (positionx, floor (positiony + yvelocity * (timeframe / 1000)) + 29).dooropen = 0) = false))
		or ((getblockfloor (positionx + 7, floor (positiony + yvelocity * (timeframe / 1000)) + 29).blockid not= 0
		and getblockfloor (positionx + 7, floor (positiony + yvelocity * (timeframe / 1000)) + 29).blockid not= 15)
		and ((getblockfloor (positionx + 7, floor (positiony + yvelocity * (timeframe / 1000)) + 29).blockid = 18
		and getblockfloor (positionx + 7, floor (positiony + yvelocity * (timeframe / 1000)) + 29).dooropen = 0) = false
		and (getblockfloor (positionx + 7, floor (positiony + yvelocity * (timeframe / 1000)) + 29).blockid = 19
		and getblockfloor (positionx + 7, floor (positiony + yvelocity * (timeframe / 1000)) + 29).dooropen = 0) = false)) then
	    yvelocity := 0
	    % If the user has not hit the ground or their head then add the velocity to the players y co-ordinate
	else
	    positiony += yvelocity * (timeframe / 1000)
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
		% If the player hits enter reset their positions and health and drop their inventory
		if chars (KEY_ENTER) then
		    for i : 1 .. 36
			if inventory (i).id not= 0 then
			    blockentities (nextentity).id := inventory (i).id
			    blockentities (nextentity).amount := inventory (i).amount
			    blockentities (nextentity).durability := inventory (i).durability
			    blockentities (nextentity).x := floor (positionx / 16)
			    blockentities (nextentity).y := floor (positiony / 16)
			    nextentity += 1
			    if nextentity > 1000 then
				nextentity := 1
			    end if
			end if
			inventory (i).id := 0
			inventory (i).amount := 0
			inventory (i).durability := 0
		    end for
		    positionxreal := spawnpointx * 16
		    positiony := spawnpointy * 16
		    playerx := round (positionxreal)
		    legpivotx := round (positionxreal)
		    playerhealth := 20
		    elapsedtime := Time.Elapsed
		    exit
		end if
	    end loop
	end if
	% If the character is moving right
	if chars (rightkey) then
	    % If the block at the players feet after moving is air, torch, or open door then continue
	    if getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony)).blockid = 0 or
		    getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony)).blockid = 15
		    or ((getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony)).blockid = 18
		    and getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony)).dooropen = 0) = true
		    or (getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony)).blockid = 19
		    and getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony)).dooropen = 0) = true) then
		% If the block at the players torso after moving is air, torch, or open door then continue
		if getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony) + 15).blockid = 0 or
			getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony) + 15).blockid = 15
			or ((getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony) + 15).blockid = 18
			and getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony) + 15).dooropen = 0) = true
			or (getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony) + 15).blockid = 19
			and getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony) + 15).dooropen = 0) = true) then
		    % If the block at the players head after moving is air, torch, or open door then continue
		    if getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony) + 29).blockid = 0 or
			    getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony) + 29).blockid = 15
			    or ((getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony) + 29).blockid = 18
			    and getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony) + 29).dooropen = 0) = true
			    or (getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony) + 29).blockid = 19
			    and getblockfloor (round (positionxreal + movespeed * (timeframe / 1000)) + 7, round (positiony) + 29).dooropen = 0) = true) then
			% If after moving the player is in an outer chunk then
			if floor (round (positionxreal + (movespeed * (timeframe / 1000))) / 16 / 32) - base = 8 then
			    %Save the game to prevent incomplete save files
			    saveGame (mapname)
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
			    elapsedtime := Time.Elapsed
			end if
			% Increase the position by the movement speed
			positionxreal += movespeed * (timeframe / 1000)
		    end if
		end if
	    end if
	end if
	% If the character is moving left
	if chars (leftkey) then
	    % If the block at the players feet after moving is air, torch, or open door then continue
	    if getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony)).blockid = 0 or
		    getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony)).blockid = 15
		    or ((getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony)).blockid = 18
		    and getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony)).dooropen = 0) = true
		    or (getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony)).blockid = 19
		    and getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony)).dooropen = 0) = true) then
		% If the block at the players torso after moving is air, torch, or open door then continue
		if getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony) + 15).blockid = 0 or
			getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony) + 15).blockid = 15
			or ((getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony) + 15).blockid = 18
			and getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony) + 15).dooropen = 0) = true
			or (getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony) + 15).blockid = 19
			and getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony) + 15).dooropen = 0) = true) then
		    % If the block at the players head after moving is air, torch, or open door then continue
		    if getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony) + 29).blockid = 0 or
			    getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony) + 29).blockid = 15
			    or ((getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony) + 29).blockid = 18
			    and getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony) + 29).dooropen = 0) = true
			    or (getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony) + 29).blockid = 19
			    and getblockfloor (round (positionxreal - movespeed * (timeframe / 1000)), round (positiony) + 29).dooropen = 0) = true) then
			% If after moving the player is in an outer chunk then
			if floor (round (positionxreal - movespeed * (timeframe / 1000)) / 16 / 32) - base = 2 then
			    %Save the game to prevent incomplete save files
			    saveGame (mapname)
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
			    elapsedtime := Time.Elapsed
			end if
			% Decrease the position by the movement speed
			positionxreal -= movespeed * (timeframe / 1000)
		    end if
		end if
	    end if
	end if
	positionx := round (positionxreal)
	% Resets the exittomenu boolean to false
	var exittomenu : boolean := false
	% If the player presses the escape key, open the pause menu
	if chars (KEY_ESC) then
	    Dir.Change (maindirectory)
	    include "include/pausemenu.t"
	    elapsedtime := Time.Elapsed
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
	%If the player presses e open the inventory
	if chars ('e') and eheld = false then
	    %TAke a picture of the current screen to be shown as the background to the invent screen
	    var inventbackground : int := Pic.New (0, 0, maxx, maxy)
	    %Open the inventory
	    Dir.Change (maindirectory)
	    include "include/inventory.t"
	    % If the player was holding a block while the inventory got closed then add it to the inventor, if the inventory is full drop it at their feet
	    if holdingblock not= 0 then
		var addedtoinventory : boolean := false
		for cnt : 1 .. 36
		    if inventory (cnt).id = holdingblock then
			inventory (cnt).id := holdingblock
			inventory (cnt).amount += holdingamount
			addedtoinventory := true
			exit
		    end if
		end for
		if addedtoinventory = false then
		    for cnt : 1 .. 36
			if inventory (cnt).id = 0 then
			    inventory (cnt).id := holdingblock
			    inventory (cnt).amount += holdingamount
			    addedtoinventory := true
			    exit
			end if
		    end for
		end if
		if addedtoinventory = false then
		    blockentities (nextentity).x := floor (positionx / 16)
		    blockentities (nextentity).y := floor (positiony / 16)
		    blockentities (nextentity).id := holdingblock
		    blockentities (nextentity).amount := holdingamount
		end if
	    end if
	    elapsedtime := Time.Elapsed
	    eheld := true
	else
	    eheld := false
	end if
	var blockx, blocky : int
	% Determine the block co-ordinate based on the mouses x position
	blockx := floor (positionx - maxx / 2 + x)
	% Determine the block co-ordinate based on the mouses y position
	blocky := floor (positiony - maxy / 2 + y)
	%Subtract the timeframe from the attack delay to count down until you can attack again.
	attackdelay -= timeframe
	% If the player is pressing one of the mouse buttons
	if button = 1 or button = 100 then
	    % If the mouse is within the reach range
	    if Math.Distance (404, 344, x, y) < 50 then
		%Loop through all mobx
		for i : 1 .. upper (mobs)
		    %Check for mouse collision
		    if blockx >= mobs (i).x and blockx <= mobs (i).x + 8 then
			if blocky >= mobs (i).y and blocky <= mobs (i).y + 32 then
			    %If presing the attack button
			    if button = 1 then
				%If you havent attacked in the past 0.5 seconds
				if attackdelay <= 0 then
				    %Variable for mob damage, will be set then applied
				    var mobdamage : int := 0
				    %If the item is a tool, the equation is 2*(strength/4), if its a sword, its 2*strength
				    if blockinfos (inventory (currentblock).id).tool = true then
					if blockinfos (inventory (currentblock).id).tooltype = 4 then
					    mobdamage := 2 * blockinfos (inventory (currentblock).id).strength
					else
					    mobdamage := round (2 * (blockinfos (inventory (currentblock).id).strength / 4))
					    if mobdamage < 2 then
						mobdamage := 2
					    end if
					end if
					%Use a durabiltiy use
					inventory (currentblock).durability += 1
					%Default damage no tool is 2
				    else
					mobdamage := 2
				    end if
				    %Plays a zombie hurt sound
				    var zombiesound := Rand.Int (1, 2)
				    playsoundeffect ("zombiehurt" + intstr (zombiesound) + ".wav")
				    %Subtract the damage from the mobs health
				    mobs (i).health -= mobdamage
				    %Reset the attack delay to prevent spamming
				    attackdelay := 500
				end if
			    end if
			end if
		    end if
		end for
		% If the block is within the building heights
		if floor (blocky / 16) > 0 and floor (blocky / 16) < 128 then
		    % If the block is not inside the player
		    if ((floor (blockx / 16) = floor (positionx / 16) and floor (blocky / 16) = floor (positiony / 16))
			    or (floor (blockx / 16) = floor (positionx / 16) and (floor (blocky / 16)) = floor ((positiony + 29) / 16))
			    or (floor (blockx / 16) = floor (positionx / 16) and (floor (blocky / 16)) = floor ((positiony + 15) / 16))
			    or (floor (blockx / 16) = floor ((positionx + 7) / 16) and floor (blocky / 16) = floor (positiony / 16))
			    or (floor (blockx / 16) = floor ((positionx + 7) / 16) and (floor (blocky / 16)) = floor ((positiony + 29) / 16))
			    or (floor (blockx / 16) = floor ((positionx + 7) / 16) and (floor (blocky / 16)) = floor ((positiony + 15) / 16)))
			    = false then
			% If the left button is pressed
			if button = 1 then
			    %If the block being broken is not air or bedrock then
			    if chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid not= 0 then
				if chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid not= 1 then
				    %The temporary hardness is the same as the blocks hardness
				    hardness := blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).hardness
				    %Increment tohe break timer
				    breaktimer += timeframe
				    %If the block has a weakness
				    if blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).weakness not= 0 then
					%If the current inventory block is not air
					if inventory (currentblock).id not= 0 then
					    %If the current inventory block is a tool
					    if blockinfos (inventory (currentblock).id).tool = true then
						%If the current inventory blocks tooltype is the type that the block is weak to
						if blockinfos (inventory (currentblock).id).tooltype = blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod
							32) (floor (blocky /
							16)).blockid).weakness then
						    % Hardness is divided by the strength making it break faster
						    hardness := floor (hardness / blockinfos (inventory (currentblock).id).strength)
						    %Calculates the breaking stage
						    breakstage := floor (breaktimer * 10 / hardness)
						else
						    breakstage := floor (breaktimer * 10 / hardness)
						end if
					    else
						breakstage := floor (breaktimer * 10 / hardness)
					    end if
					else
					    breakstage := floor (breaktimer * 10 / hardness)
					end if
				    else
					breakstage := floor (breaktimer * 10 / hardness)
				    end if
				    %If the block being broken is not the one that was being broken reset the timer and breakstage
				    if (breakingblockx not= blockx div 16) or (breakingblocky not= blocky div 16) then
					breakstage := -1
					breaktimer := 0
				    end if
				    %Sets the block being broken to the one the mouse is highlighting
				    breakingblockx := blockx div 16
				    breakingblocky := blocky div 16
				    %If the block has been broken
				    if breaktimer >= hardness then
					%IF the block being broken is diamond
					if chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid = 10 then
					    %If the block has a required tooltype and the tool is being used or the block does not have a required tooltype
					    if (blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).tooltyperequired and
						    blockinfos (inventory (currentblock).id).tool and blockinfos (inventory (currentblock).id).tooltype =
						    blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).weakness) or
						    (blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).tooltyperequired
						    =
						    false) then
						%Create a new block entity holding this block
						blockentities (nextentity).x := floor (blockx / 16)
						blockentities (nextentity).y := floor (blocky / 16)
						blockentities (nextentity).id := 13
						blockentities (nextentity).amount := 1
						%Drop this entity to the ground
						if getblockfloor (blockx, blocky - 16).blockid = 0 or getblockfloor (blockx, blocky - 16).blockid = 15
							then
						    for decreasing i : blocky - 32 .. 0 by 16
							if getblockfloor (blockx, i).blockid not= 0 and getblockfloor (blockx, i).blockid
								not= 15 then
							    blockentities (nextentity).y := floor (i / 16) + 1
							    exit
							end if
						    end for
						end if
						%Increment the nextentity for the next entity being dropped
						nextentity += 1
						if nextentity > 1000 then
						    nextentity := 1
						end if
					    end if
					    %If the block is coal
					elsif chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid = 9 then
					    %If the block has a required tooltype and the tool is being used or the block does not have a required tooltype
					    if (blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).tooltyperequired and
						    blockinfos (inventory (currentblock).id).tool and blockinfos (inventory (currentblock).id).tooltype =
						    blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).weakness) or
						    (blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).tooltyperequired
						    =
						    false) then
						%Create a new block entity holding this block
						blockentities (nextentity).x := floor (blockx / 16)
						blockentities (nextentity).y := floor (blocky / 16)
						blockentities (nextentity).id := 14
						blockentities (nextentity).amount := 1
						%Drop this entity to the ground
						if getblockfloor (blockx, blocky - 16).blockid = 0 or getblockfloor (blockx, blocky - 16).blockid = 15
							then
						    for decreasing i : blocky - 32 .. 0 by 16
							if getblockfloor (blockx, i).blockid not= 0 and getblockfloor (blockx, i).blockid
								not= 15 then
							    blockentities (nextentity).y := floor (i / 16) + 1
							    exit
							end if
						    end for
						end if
						%Increment the nextentity for the next entity being dropped
						nextentity += 1
						if nextentity > 1000 then
						    nextentity := 1
						end if
					    end if
					    %If the block broken is a door
					elsif chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid = 18 or
						chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid = 19 then
					    %If the block has a required tooltype and the tool is being used or the block does not have a required tooltype
					    if (blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).tooltyperequired and
						    blockinfos (inventory (currentblock).id).tool and blockinfos (inventory (currentblock).id).tooltype =
						    blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).weakness) or
						    (blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).tooltyperequired
						    =
						    false) then
						%Create a new block entity holding this block
						blockentities (nextentity).x := floor (blockx / 16)
						blockentities (nextentity).y := floor (blocky / 16)
						blockentities (nextentity).id := 128
						blockentities (nextentity).amount := 1
						%Drop the entity to the ground
						if getblockfloor (blockx, blocky - 16).blockid = 0 or getblockfloor (blockx, blocky - 16).blockid = 15
							or getblockfloor (blockx, blocky - 16).blockid = 18 then
						    for decreasing i : blocky - 32 .. 0 by 16
							if getblockfloor (blockx, i).blockid not= 0 and getblockfloor (blockx, i).blockid
								not= 15 then
							    blockentities (nextentity).y := floor (i / 16) + 1
							    exit
							end if
						    end for
						end if
						%Increment the nextentity for the next entity being dropped
						nextentity += 1
						if nextentity > 1000 then
						    nextentity := 1
						end if
					    end if
					    %If the block is not a leaf block(They dont drop items, yet)
					elsif chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid not= 16 then
					    %If the block has a required tooltype and the tool is being used or the block does not have a required tooltype
					    if (blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).tooltyperequired and
						    blockinfos (inventory (currentblock).id).tool and blockinfos (inventory (currentblock).id).tooltype =
						    blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).weakness) or
						    (blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).tooltyperequired
						    =
						    false) then
						%Create a new block entity holding this block
						blockentities (nextentity).x := floor (blockx / 16)
						blockentities (nextentity).y := floor (blocky / 16)
						blockentities (nextentity).id := chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid
						blockentities (nextentity).amount := 1
						%Drop all possible entities to the ground
						for decreasing i : blocky - 16 .. 0 by 16
						    if getblockfloor (blockx, i).blockid not= 0 and getblockfloor (blockx, i).blockid
							    not= 15 then
							for cnt : 1 .. upper (blockentities)
							    if (blockentities (cnt).y = floor (blocky / 16) or blockentities (cnt).y = floor (blocky / 16) + 1) and blockentities (cnt).x =
								    floor (blockx / 16) then
								blockentities (cnt).y := floor (i / 16) + 1
							    end if
							end for
							exit
						    end if
						end for
						%Increment the nextentity for the next entity being dropped
						nextentity += 1
						if nextentity > 1000 then
						    nextentity := 1
						end if
					    end if
					end if
					%If the block being broken has a weakness
					if blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid).weakness not= 0 then
					    %If the current inventory item is a tool and its strength matches the block brokens weakness
					    if inventory (currentblock).id not= 0 then
						if blockinfos (inventory (currentblock).id).tool = true then
						    if blockinfos (inventory (currentblock).id).tooltype = blockinfos (chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16)
							    mod 32) (floor (blocky / 16)).blockid).weakness then
							%Increment the tools durability
							inventory (currentblock).durability += 1
							%If the tool has run out of uses break it
							if inventory (currentblock).durability >= blockinfos (inventory (currentblock).id).durability then
							    if inventory (currentblock).amount = 1 then
								inventory (currentblock).id := 0
								inventory (currentblock).amount := 0
								inventory (currentblock).durability := 0
							    else
								inventory (currentblock).amount -= 1
								inventory (currentblock).durability := 0
							    end if
							end if
						    end if
						else
						    breakstage := floor (breaktimer * 10 / hardness)
						end if
					    else
						breakstage := floor (breaktimer * 10 / hardness)
					    end if
					end if
					%If the block being broken is not a door
					if chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid not= 19
						and chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid not= 18 then
					    % Set the block to air
					    chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid := 0
					else
					    %If the bootom door is broken set the block and the one above to air
					    if chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid = 18 then
						chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid := 0
						chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).dooropen := 0
						chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16) + 1).blockid := 0
						chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16) + 1).dooropen := 0
						%If its the top set the block and the one below to air
					    else
						chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid := 0
						chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).dooropen := 0
						chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16) - 1).blockid := 0
						chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16) - 1).dooropen := 0
					    end if
					end if
					%Reset the timer and breakstage
					breaktimer := 0
					breakstage := -1
					%Update the lighting
					updateLighting (floor (((blockx) / 16) / 32), floor ((blockx) / 16) mod 32, floor (blocky / 16))
					timeframe := Time.Elapsed - elapsedtime
					elapsedtime := Time.Elapsed
				    end if
				else
				    breaktimer := 0
				    breakstage := -1
				end if
			    else
				breaktimer := 0
				breakstage := -1
			    end if
			    % If the right mouse button is clicked
			elsif button = 100 then
			    breaktimer := 0
			    breakstage := -1
			    % If the block being attempted to be modified is an air block
			    if getblockfloor (blockx, blocky).blockid = 0 then
				%If the block being placed is not air, is placable, and is not a door then
				if inventory (currentblock).id not= 0 and (blockinfos (inventory (currentblock).id).placable not= 1 and inventory (currentblock).id not= 128) then
				    % Set the block selected to the currently selected inventory block
				    chunks ((floor (((blockx) / 16) / 32)) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid := inventory (currentblock).id
				    %Decrement the amount in inventory
				    inventory (currentblock).amount -= 1
				    if inventory (currentblock).amount <= 0 then
					inventory (currentblock).id := 0
					inventory (currentblock).amount := 0
				    end if
				    %Update the lighting
				    updateLighting (floor (((blockx) / 16) / 32), floor ((blockx) / 16) mod 32, floor (blocky / 16))
				    timeframe := Time.Elapsed - elapsedtime
				    elapsedtime := Time.Elapsed
				    %If the block bing placed is a door
				elsif inventory (currentblock).id = 128 then
				    %If the block being modified is an air block
				    if chunks ((floor (((blockx) / 16) / 32)) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16) + 1).blockid = 0 then
					% Set the block selected to the the bottom of the door and the block above to the top of the door
					chunks ((floor (((blockx) / 16) / 32)) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid := 18
					chunks ((floor (((blockx) / 16) / 32)) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16) + 1).blockid := 19
					%Decrement the inventory amount
					inventory (currentblock).amount -= 1
					if inventory (currentblock).amount <= 0 then
					    inventory (currentblock).id := 0
					    inventory (currentblock).amount := 0
					end if
					%Update the lighting
					updateLighting (floor (((blockx) / 16) / 32), floor ((blockx) / 16) mod 32, floor (blocky / 16))
					timeframe := Time.Elapsed - elapsedtime
					elapsedtime := Time.Elapsed
				    end if
				end if
				%If the block being right clicked is a crafting bench
			    elsif getblockfloor (blockx, blocky).blockid = 12 then
				Dir.Change (maindirectory)
				%Save the screen as the crafting tbale background
				var craftingbackground : int := Pic.New (0, 0, maxx, maxy)
				%Open the crafting table
				include "include/crafting.t"
				%If the player has holding a block when the screen was exited, put it in their inventory, if their inventory is full drop it on the ground
				if holdingblock not= 0 then
				    var addedtoinventory : boolean := false
				    for cnt : 1 .. 36
					if inventory (cnt).id = holdingblock then
					    inventory (cnt).id := holdingblock
					    inventory (cnt).amount += holdingamount
					    addedtoinventory := true
					    exit
					end if
				    end for
				    if addedtoinventory = false then
					for cnt : 1 .. 36
					    if inventory (cnt).id = 0 then
						inventory (cnt).id := holdingblock
						inventory (cnt).amount += holdingamount
						addedtoinventory := true
						exit
					    end if
					end for
				    end if
				    if addedtoinventory = false then
					blockentities (nextentity).x := floor (positionx / 16)
					blockentities (nextentity).y := floor (positiony / 16)
					blockentities (nextentity).id := holdingblock
					blockentities (nextentity).amount := holdingamount
				    end if
				end if
				elapsedtime := Time.Elapsed
				%If the block being right clicked is a a door
			    elsif (getblockfloor (blockx, blocky).blockid = 18 or getblockfloor (blockx, blocky).blockid = 19) and doorclick = false then
				%If its open, close it and the other door piece, if its closed, open it and the other door piece
				if getblockfloor (blockx, blocky).dooropen = 0 then
				    chunks ((floor (((blockx) / 16) / 32)) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).dooropen := 1
				    if getblockfloor (blockx, blocky).blockid = 18 then
					chunks ((floor (((blockx) / 16) / 32)) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16) + 1).dooropen := 1
				    else
					chunks ((floor (((blockx) / 16) / 32)) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16) - 1).dooropen := 1
				    end if
				else
				    chunks ((floor (((blockx) / 16) / 32)) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).dooropen := 0
				    if getblockfloor (blockx, blocky).blockid = 18 then
					chunks ((floor (((blockx) / 16) / 32)) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16) + 1).dooropen := 0
				    else
					chunks ((floor (((blockx) / 16) / 32)) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16) - 1).dooropen := 0
				    end if
				end if
				%Prevent doors flickering when clicked
				doorclick := true
			    end if
			end if
		    else
			breaktimer := 0
			breakstage := -1
		    end if
		end if
	    end if
	else
	    breaktimer := 0
	    breakstage := -1
	    doorclick := false
	end if
	%Update
	for i : 1 .. upper (mobs)
	    if i <= upper (mobs) then
		%If the mob is dead, remove it from the game
		if mobs (i).health <= 0 then
		    playsoundeffect ("zombiedeath.wav")
		    for cnt : i .. upper (mobs) - 1
			mobs (cnt) := mobs (cnt + 1)
		    end for
		    new mobs, upper (mobs) - 1
		    %If its out of range, kill it
		elsif abs (mobs (i).x - positionx) > 1536 then
		    for cnt : i .. upper (mobs) - 1
			mobs (cnt) := mobs (cnt + 1)
		    end for
		    new mobs, upper (mobs) - 1
		    %If its not then update it
		else
		    %If its close to the player, occasionally play a groaning sound
		    if abs (mobs (i).x - positionx) < 500 then
			if Rand.Int (1, 500) = 15 then
			    var zombiesound := Rand.Int (1, 3)
			    playsoundeffect ("zombie" + intstr (zombiesound) + ".wav")
			end if
		    end if
		    %If its on fire gradually deplete its health
		    if mobs (i).onfire > 0 then
			mobs (i).onfire -= timeframe
			if ceil (mobs (i).onfire / 1000) not= mobs (i).firestage then
			    mobs (i).firestage := ceil (mobs (i).onfire / 1000)
			    mobs (i).health -= 1
			end if
		    else
			mobs (i).onfire := 0
		    end if
		    %Prevents mobs from spamming attack
		    mobs (i).hittimer -= timeframe
		    %This is to determine whether the mob has to jump or not
		    var moved : boolean := false
		    %IF the mob is to the left of the player, attempt to move it right
		    if positionx - mobs (i).x > 8 then
			% If the block at the mobs feet after moving is air, torch, or open door then continue
			if getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y)).blockid = 0 or
				getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y)).blockid = 15
				or ((getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y)).blockid = 18
				and getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y)).dooropen = 0) = true
				or (getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y)).blockid = 19
				and getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y)).dooropen = 0) = true) then
			    % If the block at the mobs torso after moving is air, torch, or open door then continue
			    if getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y) + 15).blockid = 0 or
				    getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y) + 15).blockid = 15
				    or ((getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y) + 15).blockid = 18
				    and getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y) + 15).dooropen = 0) = true
				    or (getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y) + 15).blockid = 19
				    and getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y) + 15).dooropen = 0) = true) then
				% If the block at the mobs head after moving is air, torch, or open door then continue
				if getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y) + 29).blockid = 0 or
					getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y) + 29).blockid = 15
					or ((getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y) + 29).blockid = 18
					and getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y) + 29).dooropen = 0) = true
					or (getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y) + 29).blockid = 19
					and getblockfloor (round (mobs (i).x + mobs (i).movespeed * (timeframe / 1000)) + 7, round (mobs (i).y) + 29).dooropen = 0) = true) then
				    %If the mob can be moved then move it and set the moved variable to true
				    mobs (i).x += mobs (i).movespeed * (timeframe / 1000)
				    moved := true
				end if
			    end if
			end if
			%If the mob is to the right of the player, attempt to move it left
		    elsif mobs (i).x - positionx > 8 then
			% If the block at the mobs feet after moving is air, torch, or open door then continue
			if getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y)).blockid = 0 or
				getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y)).blockid = 15
				or ((getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y)).blockid = 18
				and getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y)).dooropen = 0) = true
				or (getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y)).blockid = 19
				and getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y)).dooropen = 0) = true) then
			    % If the block at the mobs torso after moving is air, torch, or open door then continue
			    if getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y) + 15).blockid = 0 or
				    getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y) + 15).blockid = 15
				    or ((getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y) + 15).blockid = 18
				    and getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y) + 15).dooropen = 0) = true
				    or (getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y) + 15).blockid = 19
				    and getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y) + 15).dooropen = 0) = true) then
				% If the block at the mobs head after moving is air, torch, or open door then continue
				if getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y) + 29).blockid = 0 or
					getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y) + 29).blockid = 15
					or ((getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y) + 29).blockid = 18
					and getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y) + 29).dooropen = 0) = true
					or (getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y) + 29).blockid = 19
					and getblockfloor (round (mobs (i).x - mobs (i).movespeed * (timeframe / 1000)), round (mobs (i).y) + 29).dooropen = 0) = true) then
				    %If the mob can be moved move it and set the moved variable to true
				    mobs (i).x -= mobs (i).movespeed * (timeframe / 1000)
				    moved := true
				end if
			    end if
			end if
			%If the mob is touching the player
		    else
			%If the mob can reach the player in y values, say it has moved to prevent jumping, same with if its above the player, if its below, make it jump
			if abs (mobs (i).y - positiony) < 32 then
			    moved := true
			elsif mobs (i).y < positiony then
			else
			    moved := true
			end if
		    end if
		    %IF the mob is touching the player
		    if abs (mobs (i).y - positiony) < 32 and abs (mobs (i).x - positionx) < 16 then
			%If the mob has waited long enough to attack
			if mobs (i).hittimer <= 0 then
			    %DEcrease tha players health, play the damaged sound, and increase the mobs hittimer again
			    playerhealth -= 4
			    playsoundeffect ("hurt.wav")
			    mobs (i).hittimer := 500
			end if
		    end if
		    %If the mob hasnt moved and its on the ground then make it jump
		    if moved = false then
			if mobs (i).collision = 1 then
			    mobs (i).collision := 0
			    mobs (i).yvelocity := 72
			end if
		    end if
		    % If the mob has not reached terminal velocity then add gravity to the mobs velocity
		    if mobs (i).yvelocity > -terminalvelocity then
			if timeframe < 500 then
			    mobs (i).yvelocity += gravity * (timeframe / 1000)
			end if
			% If the mob is at or above terminal velocity limit the mob to terminal velocity
		    else
			mobs (i).yvelocity := -terminalvelocity
		    end if
		    % If the mob is on the falling portion of their jump add the velocity to the accumulative damage
		    if mobs (i).yvelocity < 0 then
			if timeframe < 500 then
			    mobs (i).damage -= mobs (i).yvelocity * (timeframe / 1000)
			end if
		    end if
		    % Set the collision (On ground) to false so the mob cannot jump mid-air if he/she walks off a ledge
		    mobs (i).collision := 0
		    % If the right side of the mob or the left side of the mob is on a block then
		    if ((getblockfloor (round (mobs (i).x), floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000))).blockid not= 0
			    and getblockfloor (round (mobs (i).x), floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000))).blockid not= 15)
			    and ((getblockfloor (round (mobs (i).x), floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000))).blockid = 18
			    and getblockfloor (round (mobs (i).x), floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000))).dooropen = 0) = false
			    and (getblockfloor (round (mobs (i).x), floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000))).blockid = 19
			    and getblockfloor (round (mobs (i).x), floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000))).dooropen = 0) = false))
			    or ((getblockfloor (round (mobs (i).x) + 7, floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000))).blockid not= 0
			    and getblockfloor (round (mobs (i).x) + 7, floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000))).blockid not= 15)
			    and ((getblockfloor (round (mobs (i).x) + 7, floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000))).blockid = 18
			    and getblockfloor (round (mobs (i).x) + 7, floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000))).dooropen = 0) = false
			    and (getblockfloor (round (mobs (i).x) + 7, floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000))).blockid = 19
			    and getblockfloor (round (mobs (i).x) + 7, floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000))).dooropen = 0) = false)) then
			% Set the collison (On ground) to true
			mobs (i).collision := 1
			% If the damage is greater than 64 (4 blocks fall) then subtract 4 blocks from the damage and subtract the damage from the mobs health
			if mobs (i).damage > 64 then
			    mobs (i).damage -= 64
			    mobs (i).health -= floor (mobs (i).damage / 16)
			end if
			% Reset the damage and velocity variables for the next fall
			mobs (i).damage := 0
			mobs (i).yvelocity := 0
			% Set the mob onto the ground
			mobs (i).y := floor (mobs (i).y / 16) * 16
			%If the mob has hit their head, drop their velocity to 0 so they begin falling again
		    elsif ((getblockfloor (round (mobs (i).x), floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000)) + 29).blockid not= 0
			    and getblockfloor (round (mobs (i).x), floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000)) + 29).blockid not= 15)
			    and ((getblockfloor (round (mobs (i).x), floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000)) + 29).blockid = 18
			    and getblockfloor (round (mobs (i).x), floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000)) + 29).dooropen = 0) = false
			    and (getblockfloor (round (mobs (i).x), floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000)) + 29).blockid = 19
			    and getblockfloor (round (mobs (i).x), floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000)) + 29).dooropen = 0) = false))
			    or ((getblockfloor (round (mobs (i).x) + 7, floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000)) + 29).blockid not= 0
			    and getblockfloor (round (mobs (i).x) + 7, floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000)) + 29).blockid not= 15)
			    and ((getblockfloor (round (mobs (i).x) + 7, floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000)) + 29).blockid = 18
			    and getblockfloor (round (mobs (i).x) + 7, floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000)) + 29).dooropen = 0) = false
			    and (getblockfloor (round (mobs (i).x) + 7, floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000)) + 29).blockid = 19
			    and getblockfloor (round (mobs (i).x) + 7, floor (mobs (i).y + mobs (i).yvelocity * (timeframe / 1000)) + 29).dooropen = 0) = false)) then
			mobs (i).yvelocity := 0
			% If the mob has not hit the ground or their head then add the velocity to the mobs y co-ordinate
		    else
			mobs (i).y += mobs (i).yvelocity * (timeframe / 1000)
		    end if
		end if
	    end if
	end for
	%If its time to update the blockentities
	if floor (blocktimer / 1000) > blockupdatetimers then
	    %Loop through all the block entities and increment their timers
	    for i : 1 .. upper (blockentities)
		if blockentities (i).timer < blockdespawntime then
		    blockentities (i).timer += blockupdatetimers
		end if
		%If its time to despawn it do so
		if blockentities (i).timer >= blockdespawntime then
		    blockentities (i).x := 0
		    blockentities (i).y := 0
		    blockentities (i).id := 0
		    blockentities (i).amount := 0
		    blockentities (i).durability := 0
		    blockentities (i).timer := 0
		end if
	    end for
	    blocktimer := 0
	    elapsedtime := Time.Elapsed
	end if
	%Increment the block timer
	blocktimer += timeframe
	%Loops through all block entities
	for i : 1 .. upper (blockentities)
	    %If the player is close enough to the blockentity
	    if blockentities (i).x > floor ((positionx - 2) / 16) - 1 and blockentities (i).x < floor ((positionx + 9) / 16) + 1 and blockentities (i).y > floor (positiony / 16) - 1 and
		    blockentities (i).y <
		    floor (positiony / 16) + 3 then
		%Add it to the inventory
		var addedtoinventory : boolean := false
		for cnt : 1 .. 36
		    if inventory (cnt).id = blockentities (i).id then
			inventory (cnt).id := blockentities (i).id
			inventory (cnt).amount += blockentities (i).amount
			inventory (cnt).durability := blockentities (i).durability
			addedtoinventory := true
			exit
		    end if
		end for
		if addedtoinventory = false then
		    for cnt : 1 .. 36
			if inventory (cnt).id = 0 then
			    inventory (cnt).id := blockentities (i).id
			    inventory (cnt).amount := blockentities (i).amount
			    inventory (cnt).durability := blockentities (i).durability
			    addedtoinventory := true
			    exit
			end if
		    end for
		end if
		%If it was successfully added then delete the entity
		if addedtoinventory = true then
		    blockentities (i).id := 0
		    blockentities (i).amount := 0
		    blockentities (i).durability := 0
		    blockentities (i).x := 0
		    blockentities (i).y := 0
		end if
	    end if
	end for
	% Increment the tick timer
	tickTime += timeframe
	%If a tick is ready
	if tickTime >= tickLength then
	    %THe start and ending are the chunk the player is in and the 2 around it
	    var start : int := floor (positionx / 16 / 32) - base - 1
	    var ending : int := floor (positionx / 16 / 32) - base + 1
	    %For all the chunks being updated
	    for i : start .. ending
		% For all the blocks in the chunk
		for treex : 0 .. 31
		    for treey : 1 .. 128
			%If the block is a leaf
			if chunks (i).blocks (treex) (treey).blockid = 16 then
			    %50% chance to destroy the leaf
			    if Rand.Int (1, 100) < 50 then
				% Whether there is a tree nearby
				var treePresent : boolean := false
				%Looks 5 blocks in each direction
				for a : -5 .. 5
				    for b : -5 .. 5
					%If there is a wood block in that region then there is a tree(Not always, but who will ever know)
					if treex + a >= 0 and treex + a <= 31 then
					    if chunks (i).blocks (treex + a) (treey + b).blockid = 6 then
						treePresent := true
					    end if
					elsif treex + a < 0 then
					    if i + 1 >= 0 then
						if chunks (i - 1).blocks (31 + treex + a) (treey + b).blockid = 6 then
						    treePresent := true
						end if
					    end if
					elsif treex + a > 31 then
					    if i + 1 <= 10 then
						if chunks (i + 1).blocks (treex + a - 31) (treey + b).blockid = 6 then
						    treePresent := true
						end if
					    end if
					end if
				    end for
				end for
				%If there is no tree the delete the leaf and update the lighting
				if treePresent not= true then
				    chunks (i).blocks (treex) (treey).blockid := 0
				    updateLighting (base + i, treex, treey)
				end if
			    end if
			end if
		    end for
		end for
	    end for
	    %For all chunks, pick 10 locations to attempt to spawn a zombie, if the zombie is directly above a block, there is room to spawn, the light level is dark enough, and it passes a 10% random test. Spawn a zombie
	    for i : 1 .. 10
		for j : 1 .. 10
		    var mobspawnx := Rand.Int (0, 31)
		    var mobspawny := Rand.Int (2, 127)
		    if chunks (i).blocks (mobspawnx) (mobspawny - 1).blockid not= 0 and chunks (i).blocks (mobspawnx) (mobspawny - 1).blockid not= 15 then
			if chunks (i).blocks (mobspawnx) (mobspawny).blockid = 0 or chunks (i).blocks (mobspawnx) (mobspawny).blockid = 15 then
			    if chunks (i).blocks (mobspawnx) (mobspawny + 1).blockid = 0 or chunks (i).blocks (mobspawnx) (mobspawny + 1).blockid = 15 then
				if chunks (i).blocks (mobspawnx) (mobspawny).lightlevel >= 3 then
				    if Rand.Int (1, 10) = 5 then
					new mobs, upper (mobs) + 1
					mobs (upper (mobs)).x := (((base + i) * 32) + mobspawnx) * 16
					mobs (upper (mobs)).y := mobspawny * 16
					mobs (upper (mobs)).idtype := 1
					mobs (upper (mobs)).health := 12
					mobs (upper (mobs)).damage := 0
					mobs (upper (mobs)).firestage := 0
					mobs (upper (mobs)).onfire := 0
					mobs (upper (mobs)).yvelocity := 0
					mobs (upper (mobs)).movespeed := 24
					mobs (upper (mobs)).legpivotx := mobs (upper (mobs)).x
				    end if
				end if
			    end if
			end if
		    end if
		end for
	    end for
	    %If its daytime, check each mob to see if its being touched by sunlight, if so then begin burning it.
	    if daytime = true then
		for i : 1 .. upper (mobs)
		    var sunlighttouching : boolean := true
		    for decreasing ycnt : 128 .. round (mobs (i).y / 16)
			if getblockfloor (round (mobs (i).x), ycnt * 16).blockid not= 0 and getblockfloor (round (mobs (i).x), ycnt * 16).blockid not= 15 then
			    sunlighttouching := false
			end if
		    end for
		    if sunlighttouching = true then
			mobs (i).onfire := 5000
		    end if
		end for
	    end if
	    tickTime := 0
	    elapsedtime := Time.Elapsed
	end if
	%Sets the daytime variable according to the gametime.
	if (ingametime mod 1280) >= 640 then
	    daytime := false
	else
	    daytime := true
	end if
	%Checks to make sure all chunks are correctly lighted according to time of day.
	for i : 0 .. 10
	    if daytime and chunks (5).day = 0 then
		changeCycle (true)
		elapsedtime := Time.Elapsed
	    elsif daytime not= true and chunks (5).day = 1 then
		changeCycle (false)
		elapsedtime := Time.Elapsed
	    end if
	end for
	%Draws the background
	Pic.Draw (background, 0, round ((ingametime) mod 1280) - 640, picCopy)
	Pic.Draw (background, 0, round ((ingametime) mod 1280 - 1920), picCopy)
	% Calculates the left right top and bottom blocks by subtracting or adding half the screen as the player will always be centered
	leftblockx := floor (positionx - maxx / 2)
	rightblockx := floor (positionx + maxx / 2)
	bottomblocky := floor (positiony - maxy / 2)
	topblocky := floor (positiony + maxy / 2)
	% x and y offsets are calculated be getting the remaining pixels of the block that will be cut off
	xoffset := -round (positionx mod 16)
	yoffset := -round (positiony mod 16)
	%Next 8 lines are for sectioning the rendering, but are unused as they don't look good
	var sections := maxy / sectionPart
	if collision then
	    low := updatePart * floor (sections) + yoffset
	    high := (updatePart + 1) * ceil (sections) + yoffset
	else
	    low := yoffset
	    high := maxy + yoffset
	end if
	% Loops through every block on the x axis of the screen
	for i : xoffset .. maxx + xoffset by 16
	    % Loops through every block on the y axis of the screen
	    for j : low .. high by 16
		% Verifies that the block being drawn is within the boundaries of the map
		if (bottomblocky + j) div 16 >= 1 and (bottomblocky + j) div 16 <= 128 then
		    % Only draws the block if it is not sky
		    if getblockfloor (((leftblockx + (i - xoffset))), ((bottomblocky + (j - yoffset)))).blockid not= 0 then
			% Draws the block at the current position. The block is calculated by adding the offset (Offset is negative so we have to subtract it to get it positive)
			% to the current position on the screen and then added to the left/bottom blocks position.
			% This is then divided by 16 so we can get it from the blocks array
			%If the block is a torch, or a door (Transparency)
			if getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j - yoffset)).blockid = 15
				or getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j - yoffset)).blockid = 18
				or getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j - yoffset)).blockid = 19
				or getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j - yoffset)).blockid = 27 then
			    %If the door is open(Torches and cactus are open too so it doesn't interfere)
			    if getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j - yoffset)).dooropen = 0 then
				%Draw it with transparency
				Pic.Draw (textures (getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j - yoffset)).blockid) (getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j
				    -
				    yoffset)).lightlevel), i, j, picMerge)
			    else
				%Draw the open version of the door with transparency
				if getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j - yoffset)).blockid = 18 then
				    Pic.Draw (opendoortextures (1) (getblockfloor (leftblockx + (i - xoffset),
					bottomblocky + (j - yoffset)).lightlevel), i, j, picMerge)
				else
				    Pic.Draw (opendoortextures (2) (getblockfloor (leftblockx + (i - xoffset),
					bottomblocky + (j - yoffset)).lightlevel), i, j, picMerge)
				end if
			    end if
			else
			    %If the block is bright enough to be visible
			    if getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j -
				    yoffset)).lightlevel not= 10 then
				%If the blocks are ores they need certain light levels to be seen, so it checks for them then draws it they are
				if (((getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j -
					yoffset)).blockid = 7) or (getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j -
					yoffset)).blockid = 8) or (getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j -
					yoffset)).blockid = 9)) and getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j -
					yoffset)).lightlevel < 6) or (getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j -
					yoffset)).blockid = 10 and getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j -
					yoffset)).lightlevel < 4) then
				    Pic.Draw (textures (getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j - yoffset)).blockid) (getblockfloor (leftblockx + (i - xoffset), bottomblocky
					+ (j
					-
					yoffset)).lightlevel), i, j, picCopy)
				    %If its not an ore draw it
				elsif getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j -
					yoffset)).blockid not= 7 and getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j -
					yoffset)).blockid not= 8 and getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j -
					yoffset)).blockid not= 9 and getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j -
					yoffset)).blockid not= 10 then
				    Pic.Draw (textures (getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j - yoffset)).blockid) (getblockfloor (leftblockx + (i - xoffset), bottomblocky
					+ (j
					-
					yoffset)).lightlevel), i, j, picCopy)
				    %If the block is an ore but the light level is not high enough to draw draw it as stone
				else
				    Pic.Draw (textures (2) (getblockfloor (leftblockx + (i - xoffset), bottomblocky + (j -
					yoffset)).lightlevel), i, j, picCopy)
				end if
			    else
				%If its not bright enough to draw, draw it as a black box
				Draw.FillBox (i, j, i + 15, j + 15, black)
			    end if
			end if
		    end if
		end if
	    end for
	end for
	for i : 1 .. upper (mobs)
	    if round (mobs (i).x - leftblockx) + 4 > -16 and round (mobs (i).x - leftblockx) + 4 < 800 and round (mobs (i).y - bottomblocky) > -32 and round (mobs (i).y - bottomblocky) < 640 then
		if playerdrawing = false then
		    Draw.FillBox (round (mobs (i).x - leftblockx), round (mobs (i).y - bottomblocky), round (mobs (i).x - leftblockx + 8), round (mobs (i).y - bottomblocky + 32), black)
		    Font.Draw ("z", round (mobs (i).x - leftblockx) + 1, round (mobs (i).y - bottomblocky) + 16, FPSfont, red)
		else
		    var mobdrawx, mobdrawyorig : int
		    mobdrawx := round (mobs (i).x - leftblockx) + 4
		    mobdrawyorig := round (mobs (i).y - bottomblocky)
		    var mobdirection : int := 1
		    %Set the movement direction according to the position of the mob
		    if mobs (i).x < positionx then
			mobdirection := 1
		    end if
		    if mobs (i).x > positionx then
			mobdirection := 0
		    end if
		    %The ArcCos of the distance from pivot divided by the length of the legs  gives the angle of the leg from the ground
		    %This is the calculations used for the arcCos
		    var leganglepre : real := (mobs (i).x - mobs (i).legpivotx) / 12
		    %Prevents errors
		    if leganglepre > 1 then
			leganglepre := 1
		    end if
		    if leganglepre < -1 then
			leganglepre := -1
		    end if
		    %This is the arccos, the operation was split into 2 parts to prevent errors
		    var legangle : real := arccosd (leganglepre)
		    % The angle needs to be modified slightly for leftwards movement
		    if mobdirection not= 1 then
			legangle := 180 - legangle
		    end if
		    % If the target leg movement range has been reached then change the pivot point to the position in which the previously moving leg lands
		    if legangle < 45 then
			mobs (i).legpivotx := mobs (i).legpivotx + ((mobs (i).x - mobs (i).legpivotx) * 2)
			legangle := 45
		    end if
		    if legangle < 20 or legangle > 160 then
			mobs (i).legpivotx := mobs (i).x
			legangle := 90
		    end if
		    %using the sine law we can crossmultiply and get an equation of LegLength*sin(Legangle) = x(sin90)
		    %Since sin90 is equal to 1 we can simplify the equation to x = LegLength*sin(LegAngle)
		    %This gives us the distance from the ground to the top of the leg
		    var xbody : real := 12 * sind (legangle)
		    %Drop the mobdrawy for bobbing
		    var mobdrawy := round (mobdrawyorig - (12 - xbody))
		    % Draws right side of the leg is facing the right, left if facing the left
		    if mobdirection = 1 then
			%Creates a rotated image of the leg
			rightlegmod := Pic.Rotate (zombierightleg, round (legangle) - 90, 15, 15)
			% Drwas the leg
			Pic.Draw (rightlegmod, mobdrawx - 15, mobdrawy - 5, picMerge)
			% Frees the image to prevent overflow
			Pic.Free (rightlegmod)
			%Creates a rotated image of the other leg
			rightlegmod := Pic.Rotate (zombierightleg, -round (legangle) + 90, 15, 15)
			%Draws the second leg
			Pic.Draw (rightlegmod, mobdrawx - 15, mobdrawy - 5, picMerge)
			%Frees the image to prevent overflow
			Pic.Free (rightlegmod)
		    else
			%Same as right side except with the left image
			leftlegmod := Pic.Rotate (zombieleftleg, round (legangle) - 90, 15, 15)
			Pic.Draw (leftlegmod, mobdrawx - 15, mobdrawy - 5, picMerge)
			Pic.Free (leftlegmod)
			leftlegmod := Pic.Rotate (zombieleftleg, -round (legangle) + 90, 15, 15)
			Pic.Draw (leftlegmod, mobdrawx - 15, mobdrawy - 5, picMerge)
			Pic.Free (leftlegmod)
		    end if
		    % Reassigns the calculation variables for use with the arm/head
		    armheadpivoty := round (armheadpivotyorig - (12 - xbody))
		    % Draws the body parts according to which side is visible
		    if mobdirection = 1 then
			%Draws the body at the same spot every time
			Pic.Draw (zombierightbody, mobdrawx - 2, mobdrawy + 12, picMerge)
			Pic.Draw (zombierighthead, mobdrawx - 12, mobdrawy + 12, picMerge)
			rightarmmod := Pic.Rotate (zombierightarm, 90, 15, 15)
			Pic.Draw (rightarmmod, mobdrawx - 15, mobdrawy + 7, picMerge)
			Pic.Free (rightarmmod)
		    else
			%Similar to right side except drawn with the left side and some minor angle adjustments
			Pic.Draw (zombieleftbody, mobdrawx - 2, mobdrawy + 12, picMerge)
			Pic.Draw (zombielefthead, mobdrawx - 12, mobdrawy + 12, picMerge)
			leftarmmod := Pic.Rotate (zombieleftarm, -90, 15, 15)
			Pic.Draw (leftarmmod, mobdrawx - 15, mobdrawy + 7, picMerge)
			Pic.Free (leftarmmod)
		    end if
		end if
		if mobs (i).onfire not= 0 then
		    Pic.Draw (mobfire, round (mobs (i).x - leftblockx) - 4, round (mobs (i).y - bottomblocky), picMerge)
		end if
	    end if
	end for
	%For all the block entities
	for i : 1 .. upper (blockentities)
	    %If the entity is on screen
	    if blockentities (i).x > floor ((leftblockx - xoffset) / 16) and blockentities (i).x < floor ((rightblockx - xoffset) / 16) and blockentities (i).y > floor ((bottomblocky - yoffset) /
		    16)
		    and blockentities (i).y < floor ((topblocky - yoffset) / 16) then
		%If its not air
		if blockentities (i).id not= 0 then
		    %Draw it
		    Pic.Draw (blockEntityImages (blockentities (i).id), (blockentities (i).x * 16) - leftblockx + 4, (blockentities (i).y * 16) - bottomblocky, picMerge)
		end if
	    end if
	end for
	%If the player is breaking a block, draw the animation
	if breakstage > -1 and breakstage < 10 then
	    Pic.Draw (breakinganimations (breakstage), (floor ((x - xoffset) div 16) * 16) + xoffset, (floor ((y - yoffset) div 16) * 16) + yoffset, picMerge)
	end if
	%If the players mouse is in the screen, the block ebing highlighted is in the map, and its not air, draw a highlight box around it
	if x > 0 and x < 801 and y > 0 and y < 641 then
	    if floor (blocky / 16) > 0 and floor (blocky / 16) < 129 then
		if chunks (floor (((blockx) / 16) / 32) - base).blocks (floor ((blockx) / 16) mod 32) (floor (blocky / 16)).blockid not= 0 then
		    Draw.Box ((floor ((x - xoffset) div 16) * 16) + xoffset - 1, (floor ((y - yoffset) div 16) * 16) + yoffset - 1, (floor ((x - xoffset) div 16) * 16) + xoffset + 16, (floor ((y -
			yoffset)
			div 16) *
			16) + yoffset + 16, black)
		end if
	    end if
	end if
	% Draws the inventory items
	for i : 1 .. 9
	    % If the block being drawn is the currently selected block
	    if i = currentblock then
		% Draw a red box behind it
		Draw.FillBox ((maxx div 2) - 112 + (10 * (i - 1)) + ((i - 1) * 16) - 2, 3, (maxx div 2) - 112 + (10 * (i - 1)) + ((i - 1) * 16) + 17, 22, red)
	    else
		% Draw a black box behind it
		Draw.FillBox ((maxx div 2) - 112 + (10 * (i - 1)) + ((i - 1) * 16) - 1, 4, (maxx div 2) - 112 + (10 * (i - 1)) + ((i - 1) * 16) + 16, 21, black)
	    end if
	    %Font for inventory numbering
	    var font := Font.New ("Impact:8")
	    %If the block is not air
	    if inventory (i).id > 0 then
		% Draws each inventory block with a 10 pixel gap between blocks
		if inventory (i).id = 11 or inventory (i).id = 13 or inventory (i).id = 14 or inventory (i).id = 128 or inventory (i).id = 15 or inventory (i).id = 27 or (inventory (i).id >= 20
			and inventory (i).id <= 24)
			or (inventory (i).id >= 30 and inventory (i).id <= 34) or (inventory (i).id >= 40 and inventory (i).id <= 44) or (inventory (i).id >= 50 and inventory (i).id <= 54) then
		    Pic.Draw (textures (inventory (i).id) (0), (maxx div 2) - 112 + (10 * (i - 1)) + ((i - 1) * 16), 5, picMerge)
		else
		    Pic.Draw (textures (inventory (i).id) (0), (maxx div 2) - 112 + (10 * (i - 1)) + ((i - 1) * 16), 5, picCopy)
		end if
		%Draw the amount of the item
		Font.Draw (intstr (inventory (i).amount), (maxx div 2) - 112 + (10 * (i - 1)) + ((i - 1) * 16) + 1, 6, font, white)
		%If its a tool and its durabiltyi has been partially used then draw the durability bar
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
	% Draw the player, if its not meant to be drawn draw it as a box
	if playerdrawing = false then
	    Draw.FillBox (maxx div 2, maxy div 2, maxx div 2 + 7, maxy div 2 + 29, purple)
	else
	    %Set the playerx to the positionx
	    playerx := positionx
	    %Set the movement direction according to the button pressed
	    if chars ('d') then
		movingdirection := 1
	    end if
	    if chars ('a') then
		movingdirection := 0
	    end if
	    %The ArcCos of the distance from pivot divided by the length of the legs  gives the angle of the leg from the ground
	    %This is the calculations used for the arcCos
	    var leganglepre : real := (playerx - legpivotx) / 12
	    %Prevents errors
	    if leganglepre > 1 then
		leganglepre := 1
	    end if
	    if leganglepre < -1 then
		leganglepre := -1
	    end if
	    %This is the arccos, the operation was split into 2 parts to prevent errors
	    var legangle : real := arccosd (leganglepre)
	    % The angle needs to be modified slightly for leftwards movement
	    if movingdirection not= 1 then
		legangle := 180 - legangle
	    end if
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
	    if legangle < 20 then
		legpivotx := playerx
		legangle := 90
	    end if
	    %using the sine law we can crossmultiply and get an equation of LegLength*sin(Legangle) = x(sin90)
	    %Since sin90 is equal to 1 we can simplify the equation to x = LegLength*sin(LegAngle)
	    %This gives us the distance from the ground to the top of the leg
	    var xbody : real := 12 * sind (legangle)
	    %Drop the moddley for bobbing
	    middley := round (middleyorig - (12 - xbody))
	    % Draws right side of the leg is facing the right, left if facing the left
	    if facingdirection = 1 then
		%Creates a rotated image of the leg
		rightlegmod := Pic.Rotate (rightleg, round (legangle) - 90, 15, 15)
		% Drwas the leg
		Pic.Draw (rightlegmod, middlex - 15, middley - 5, picMerge)
		% Frees the image to prevent overflow
		Pic.Free (rightlegmod)
		%Creates a rotated image of the other leg
		rightlegmod := Pic.Rotate (rightleg, -round (legangle) + 90, 15, 15)
		%Draws the second leg
		Pic.Draw (rightlegmod, middlex - 15, middley - 5, picMerge)
		%Frees the image to prevent overflow
		Pic.Free (rightlegmod)
	    else
		%Same as right side except with the left image
		leftlegmod := Pic.Rotate (leftleg, round (legangle) - 90, 15, 15)
		Pic.Draw (leftlegmod, middlex - 15, middley - 5, picMerge)
		Pic.Free (leftlegmod)
		leftlegmod := Pic.Rotate (leftleg, -round (legangle) + 90, 15, 15)
		Pic.Draw (leftlegmod, middlex - 15, middley - 5, picMerge)
		Pic.Free (leftlegmod)
	    end if
	    % Reassigns the calculation variables for use with the arm/head
	    armheadpivoty := round (armheadpivotyorig - (12 - xbody))
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
		%If swinging right then rotate it one way, if its swinging left rotate it another way
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
		%If its a tool or a stick draw it one way
		if blockinfos (inventory (currentblock).id).tool or blockinfos (inventory (currentblock).id).name = "Stick" then
		    handitem := Pic.Rotate (textures (inventory (currentblock).id) (0), round (armangle) - 45, 12, 4)
		else
		    if inventory (currentblock).id not= 0 then
			%If there is a small texture for the block then draw it, otherwise draw the large version
			if smalltextures (inventory (currentblock).id) not= 0 then
			    handitem := Pic.Rotate (smalltextures (inventory (currentblock).id), round (armangle), 4, 4)
			else
			    handitem := Pic.Rotate (textures (inventory (currentblock).id) (0), round (armangle), 4, 4)
			end if
		    end if
		end if
		var handx, handy : int
		%Calculate the hands x and y position
		handx := round (11 * sind (90 - armangle))
		handy := round (11 * sind (armangle))
		%If its a tool or stick draw it one way, otherwise draw it another
		if blockinfos (inventory (currentblock).id).tool or blockinfos (inventory (currentblock).id).name = "Stick" then
		    Pic.Draw (handitem, middlex + handx - 12, middley + 22 + handy - 4, picMerge)
		else
		    if inventory (currentblock).id not= 0 then
			Pic.Draw (handitem, middlex + handx - 4, middley + 22 + handy - 4, picMerge)
		    end if
		end if
		if inventory (currentblock).id not= 0 then
		    Pic.Free (handitem)
		end if
	    else
		%Similar to right side except drawn with the left side and some minor angle adjustments
		Pic.Draw (leftbody, middlex - 2, middley + 12, picMerge)
		leftheadmod := Pic.Rotate (lefthead, round (armangle) - 180, 12, 12)
		if Error.Last not= eNoError then
		    put Error.Last
		end if
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
		if blockinfos (inventory (currentblock).id).tool or blockinfos (inventory (currentblock).id).name = "Stick" then
		    handitem := Pic.Rotate (textures (inventory (currentblock).id) (0), round (armangle) + 135, 12, 4)
		else
		    if inventory (currentblock).id not= 0 then
			if smalltextures (inventory (currentblock).id) not= 0 then
			    handitem := Pic.Rotate (smalltextures (inventory (currentblock).id), round (armangle) + 180, 8, 4)
			else
			    handitem := Pic.Rotate (textures (inventory (currentblock).id) (0), round (armangle) + 180, 12, 4)
			end if
		    end if
		end if
		var handx, handy : int
		handx := round (10 * sind (90 - armangle))
		handy := round (10 * sind (armangle))
		if blockinfos (inventory (currentblock).id).tool or blockinfos (inventory (currentblock).id).name = "Stick" then
		    Pic.Draw (handitem, middlex + handx - 12, middley + 22 + handy - 4, picMerge)
		else
		    if inventory (currentblock).id not= 0 then
			if smalltextures (inventory (currentblock).id) not= 0 then
			    Pic.Draw (handitem, middlex + handx - 8, middley + 22 + handy - 4, picMerge)
			else
			    Pic.Draw (handitem, middlex + handx - 12, middley + 22 + handy - 4, picMerge)
			end if
		    end if
		end if
		if inventory (currentblock).id not= 0 then
		    Pic.Free (handitem)
		end if
	    end if
	end if
	% Output the FPS
	var FPSCOUNTER : string := "FPS: " + intstr (1000 div (Time.Elapsed - elapsedtime))
	%Font.Draw (FPSCOUNTER, 0, maxy - 20, FPSfont, picXor)
	% Use View.Update to create a smooth animation
	if collision then
	    View.UpdateArea (0, updatePart * floor (sections) + yoffset, maxx, (updatePart + 1) * ceil (sections) + yoffset)
	else
	    View.Update
	end if
	updatePart := (updatePart + 1) mod sectionPart
	timeframe := Time.Elapsed - elapsedtime
	ingametime += timeframe / 468.75
	elapsedtime := Time.Elapsed
    end loop
end loop
