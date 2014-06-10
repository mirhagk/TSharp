function crafttable (inputtable : array 1 .. 3 of array 1 .. 3 of item) : item
    var output : item
    output.id := 0
    output.amount := 0
    var temptable : array 1 .. 3 of array 1 .. 3 of item
    var secondtable : array 1 .. 3 of int
    for h : 1 .. upper (recipes)
	for i : 1 .. 3
	    secondtable (i) := 0
	end for
	for decreasing i : 3 .. 1
	    for decreasing j : 3 .. 1
		if recipes (h) (i) (j).id not= 0 then
		    secondtable (i) := j
		    exit
		end if
	    end for
	end for
	var width : int := 0
	var height : int := 0
	for i : 1 .. 3
	    if secondtable (i) > width then
		width := secondtable (i)
	    end if
	end for
	for decreasing i : 3 .. 1
	    if secondtable (i) not= 0 then
		height := i
		exit
	    end if
	end for
	if width = 0 then
	    width := 3
	end if
	if height = 0 then
	    height := 3
	end if
	for i : 0 .. 3 - height
	    for j : 0 .. 3 - width
		for k : 1 .. 3
		    for l : 1 .. 3
			temptable (k) (l).id := 0
		    end for
		end for
		for k : 1 .. height
		    for l : 1 .. width
			temptable (k + i) (l + j).id := recipes (h) (k) (l).id
		    end for
		end for
		var nummatches : int := 0
		for k : 1 .. 3
		    for l : 1 .. 3
			if temptable (k) (l).id = inputtable (k) (l).id then
			    nummatches += 1
			end if
		    end for
		end for
		if nummatches = 9 then
		    output.id := outputs (h).id
		    output.amount := outputs (h).amount
		end if
	    end for
	end for
    end for
    result output
end crafttable


procedure crafttableupdate (var inputtable : array 1 .. 3 of array 1 .. 3 of item)
    var outputs : flexible array 1 .. 0 of item
    var temptable : array 1 .. 3 of array 1 .. 3 of item
    var secondtable : array 1 .. 3 of int
    for h : 1 .. upper (recipes)
	for i : 1 .. 3
	    secondtable (i) := 0
	end for
	for decreasing i : 3 .. 1
	    for decreasing j : 3 .. 1
		if recipes (h) (i) (j).id not= 0 then
		    secondtable (i) := j
		    exit
		end if
	    end for
	end for
	var width : int := 0
	var height : int := 0
	for i : 1 .. 3
	    if secondtable (i) > width then
		width := secondtable (i)
	    end if
	end for
	for decreasing i : 3 .. 1
	    if secondtable (i) not= 0 then
		height := i
		exit
	    end if
	end for
	if width = 0 then
	    width := 3
	end if
	if height = 0 then
	    height := 3
	end if
	for i : 0 .. 3 - height
	    for j : 0 .. 3 - width
		for k : 1 .. 3
		    for l : 1 .. 3
			temptable (k) (l).id := 0
		    end for
		end for
		for k : 1 .. height
		    for l : 1 .. width
			temptable (k + i) (l + j).id := recipes (h) (k) (l).id
		    end for
		end for
		var nummatches : int := 0
		for k : 1 .. 3
		    for l : 1 .. 3
			if temptable (k) (l).id = inputtable (k) (l).id then
			    nummatches += 1
			end if
		    end for
		end for
		if nummatches = 9 then
		    for k : 1 .. 3
			for l : 1 .. 3
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
end crafttableupdate
