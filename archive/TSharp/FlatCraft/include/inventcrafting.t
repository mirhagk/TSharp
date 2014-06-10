%Function to return an output from a recipe
function inventtable (inputtable : array 1 .. 2 of array 1 .. 2 of item) : item
%Output item
    var output : item
    output.id := 0
    output.amount := 0
    var temptable : array 1 .. 2 of array 1 .. 2 of item
    var secondtable : array 1 .. 2 of int
    for h : 1 .. upper (recipesinvent)
	for i : 1 .. 2
	    secondtable (i) := 0
	end for
	for decreasing i : 2 .. 1
	    for decreasing j : 2 .. 1
		if recipesinvent (h) (i) (j).id not= 0 then
		    secondtable (i) := j
		    exit
		end if
	    end for
	end for
	var width : int := 0
	var height : int := 0
	for i : 1 .. 2
	    if secondtable (i) > width then
		width := secondtable (i)
	    end if
	end for
	for decreasing i : 2 .. 1
	    if secondtable (i) not= 0 then
		height := i
		exit
	    end if
	end for
	if width = 0 then
	    width := 2
	end if
	if height = 0 then
	    height := 2
	end if
	for i : 0 .. 2 - height
	    for j : 0 .. 2 - width
		for k : 1 .. 2
		    for l : 1 .. 2
			temptable (k) (l).id := 0
		    end for
		end for
		for k : 1 .. height
		    for l : 1 .. width
			temptable (k + i) (l + j).id := recipesinvent (h) (k) (l).id
		    end for
		end for
		var nummatches : int := 0
		for k : 1 .. 2
		    for l : 1 .. 2
			if temptable (k) (l).id = inputtable (k) (l).id then
			    nummatches += 1
			end if
		    end for
		end for
		if nummatches = 4 then
		    output.id := outputsinvent (h).id
		    output.amount := outputsinvent (h).amount
		end if
	    end for
	end for
    end for
    result output
end inventtable

procedure inventtableupdate (var inputtable : array 1 .. 2 of array 1 .. 2 of item)
    var temptable : array 1 .. 2 of array 1 .. 2 of item
    var secondtable : array 1 .. 2 of int
    for h : 1 .. upper (recipesinvent)
	for i : 1 .. 2
	    secondtable (i) := 0
	end for
	for decreasing i : 2 .. 1
	    for decreasing j : 2 .. 1
		if recipesinvent (h) (i) (j).id not= 0 then
		    secondtable (i) := j
		    exit
		end if
	    end for
	end for
	var width : int := 0
	var height : int := 0
	for i : 1 .. 2
	    if secondtable (i) > width then
		width := secondtable (i)
	    end if
	end for
	for decreasing i : 2 .. 1
	    if secondtable (i) not= 0 then
		height := i
		exit
	    end if
	end for
	if width = 0 then
	    width := 2
	end if
	if height = 0 then
	    height := 2
	end if
	for i : 0 .. 2 - height
	    for j : 0 .. 2 - width
		for k : 1 .. 2
		    for l : 1 .. 2
			temptable (k) (l).id := 0
		    end for
		end for
		for k : 1 .. height
		    for l : 1 .. width
			temptable (k + i) (l + j).id := recipesinvent (h) (k) (l).id
		    end for
		end for
		var nummatches : int := 0
		for k : 1 .. 2
		    for l : 1 .. 2
			if temptable (k) (l).id = inputtable (k) (l).id then
			    nummatches += 1
			end if
		    end for
		end for
		if nummatches = 4 then
		    for k : 1 .. 2
			for l : 1 .. 2
			    if inputtable (k) (l).id not= 0 then
				inputtable (k) (l).amount -= 1
				if inputtable (k) (l).amount < 1 then
				    inputtable (k) (l).id := 0
				    inputtable (k) (l).amount := 0
				end if
			    end if
			end for
		    end for
		end if
	    end for
	end for
    end for
end inventtableupdate
