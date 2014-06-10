%put "hello world"
%var name, name2 : string
%var BinaryTable, BinaryNumbers : array 1 .. 8 of int := init (1, 2, 4, 8, 16, 32, 64, 128)
%BinaryTable (1) := 1
%loop
%    get name
%    put "hi " + name
%end loop
import TuringDotNet.Window in "TuringDotNet.dll"
import TuringDotNet.Draw in "TuringDotNet.dll"
import System.Drawing.Color in "System.Drawing.dll"
%import StdLib2 in "stdLib.tu"
for i : 1 .. 10
    %put i
end for
TuringDotNet.Window.Open ("graphics:500;500")
TuringDotNet.Draw.FillOval(100,100,50,50,System.Drawing.Color.get_Black())
%put StdLib2.test (0)
/*
 var Num : int := 0
 var BinaryTable, BinaryNumbers : array 1 .. 8 of int := init (1, 2, 4, 8, 16, 32, 64, 128)
 loop
 for i : 1 .. 8
 BinaryNumbers (i) := 0
 end for
 put skip, "Enter a number less then 256 to get it's 8-bit binary form." ..
 get Num
 for decreasing i : 8 .. 1
 if Num - BinaryTable (i) >= 0 then
 BinaryNumbers (i) += 1
 Num := Num - BinaryTable (i)
 end if
 end for
 for i : 1 .. 8
 put BinaryNumbers (i), " " ..
 end for
 end loop*/
