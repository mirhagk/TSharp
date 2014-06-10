var xpos : flexible array 1 .. 0 of int
var ypos : flexible array 1 .. 0 of int
var id : flexible array 1 .. 0 of int
var name : flexible array 1 .. 0 of string
var strength : flexible array 1 .. 0 of int
var tooltype : flexible array 1 .. 0 of int
var tool : flexible array 1 .. 0 of boolean
var durability : flexible array 1 .. 0 of int
for i : 0 .. 4
    new xpos, upper (xpos) + 1
    xpos (upper (xpos)) := i * 16
    new ypos, upper (ypos) + 1
    ypos (upper (ypos)) := 144
    new tooltype, upper (tooltype) + 1
    tooltype (upper (tooltype)) := 1
    new strength, upper (strength) + 1
    strength (upper (strength)) := i * 2 + 2
    new tool, upper (tool) + 1
    tool (upper (tool)) := true
    new id, upper (id) + 1
    id (upper (id)) := 20 + i
end for
for i : 0 .. 4
    new xpos, upper (xpos) + 1
    xpos (upper (xpos)) := i * 16
    new ypos, upper (ypos) + 1
    ypos (upper (ypos)) := 160
    new tooltype, upper (tooltype) + 1
    tooltype (upper (tooltype)) := 2
    new strength, upper (strength) + 1
    strength (upper (strength)) := i * 2 + 2
    new tool, upper (tool) + 1
    tool (upper (tool)) := true
    new id, upper (id) + 1
    id (upper (id)) := 30 + i
end for
for i : 0 .. 4
    new xpos, upper (xpos) + 1
    xpos (upper (xpos)) := i * 16
    new ypos, upper (ypos) + 1
    ypos (upper (ypos)) := 128
    new tooltype, upper (tooltype) + 1
    tooltype (upper (tooltype)) := 3
    new strength, upper (strength) + 1
    strength (upper (strength)) := i * 2 + 2
    new tool, upper (tool) + 1
    tool (upper (tool)) := true
    new id, upper (id) + 1
    id (upper (id)) := 40 + i
end for
for i : 0 .. 4
    new xpos, upper (xpos) + 1
    xpos (upper (xpos)) := i * 16
    new ypos, upper (ypos) + 1
    ypos (upper (ypos)) := 176
    new tooltype, upper (tooltype) + 1
    tooltype (upper (tooltype)) := 4
    new strength, upper (strength) + 1
    strength (upper (tooltype)) := i * 2 + 2
    new tool, upper (tool) + 1
    tool (upper (tool)) := true
    new id, upper (id) + 1
    id (upper (id)) := 50 + i
end for
new name, upper (name) + 1
name (upper (name)) := "Wood Pickaxe"
new durability, upper (durability) + 1
durability (upper (durability)) := 64
new name, upper (name) + 1
name (upper (name)) := "Stone Pickaxe"
new durability, upper (durability) + 1
durability (upper (durability)) := 128
new name, upper (name) + 1
name (upper (name)) := "Iron Pickaxe"
new durability, upper (durability) + 1
durability (upper (durability)) := 512
new name, upper (name) + 1
name (upper (name)) := "Diamond Pickaxe"
new durability, upper (durability) + 1
durability (upper (durability)) := 1024
new name, upper (name) + 1
name (upper (name)) := "Gold Pickaxe"
new durability, upper (durability) + 1
durability (upper (durability)) := 32
new name, upper (name) + 1
name (upper (name)) := "Wood Shovel"
new durability, upper (durability) + 1
durability (upper (durability)) := 64
new name, upper (name) + 1
name (upper (name)) := "Stone Shovel"
new durability, upper (durability) + 1
durability (upper (durability)) := 128
new name, upper (name) + 1
name (upper (name)) := "Iron Shovel"
new durability, upper (durability) + 1
durability (upper (durability)) := 512
new name, upper (name) + 1
name (upper (name)) := "Diamond Shovel"
new durability, upper (durability) + 1
durability (upper (durability)) := 1024
new name, upper (name) + 1
name (upper (name)) := "Gold Shovel"
new durability, upper (durability) + 1
durability (upper (durability)) := 32
new name, upper (name) + 1
name (upper (name)) := "Wood Axe"
new durability, upper (durability) + 1
durability (upper (durability)) := 64
new name, upper (name) + 1
name (upper (name)) := "Stone Axe"
new durability, upper (durability) + 1
durability (upper (durability)) := 128
new name, upper (name) + 1
name (upper (name)) := "Iron Axe"
new durability, upper (durability) + 1
durability (upper (durability)) := 512
new name, upper (name) + 1
name (upper (name)) := "Diamond Axe"
new durability, upper (durability) + 1
durability (upper (durability)) := 1024
new name, upper (name) + 1
name (upper (name)) := "Gold Axe"
new durability, upper (durability) + 1
durability (upper (durability)) := 32
new name, upper (name) + 1
name (upper (name)) := "Wood Sword"
new durability, upper (durability) + 1
durability (upper (durability)) := 64
new name, upper (name) + 1
name (upper (name)) := "Stone Sword"
new durability, upper (durability) + 1
durability (upper (durability)) := 128
new name, upper (name) + 1
name (upper (name)) := "Iron Sword"
new durability, upper (durability) + 1
durability (upper (durability)) := 512
new name, upper (name) + 1
name (upper (name)) := "Diamond Sword"
new durability, upper (durability) + 1
durability (upper (durability)) := 1024
new name, upper (name) + 1
name (upper (name)) := "Gold Sword"
new durability, upper (durability) + 1
durability (upper (durability)) := 32

var stream : int
open : stream, "tools2.txt", put
for i : 1 .. upper (id)
    put : stream, "**" + intstr (i + 3) + "**"
    put : stream, "id = " + intstr (id (i))
    put : stream, "x = " + intstr (xpos (i))
    put : stream, "y = " + intstr (ypos (i))
    put : stream, "name = " + name (i)
    put : stream, "strength = " + intstr (strength (i))
    put : stream, "tooltype = " + intstr (tooltype (i))
    if tool (i) = true then
	put : stream, "tool = true"
    else
	put : stream, "tool = false"
    end if
    put : stream, "durability = " + intstr (durability (i))
    put : stream, "placable = 0"
end for
