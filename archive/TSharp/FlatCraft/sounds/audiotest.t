Draw.Dot (-1, -1, black)
var exts : array 1 .. 2 of string
var currentext : int := 1
exts (1) := ".wav"
exts (2) := ".mp3"
var block := "wood"
process playsound (name : string)
    Music.PlayFile (name + exts (currentext))
    currentext += 1
    if currentext > 2 then
	currentext := 1
    end if
end playsound
loop
    var random := Rand.Int (1, 4)
    fork playsound (block + intstr (random))
    Time.DelaySinceLast (200)
end loop
