/*script to generate a list of randomly-selected compartments*/

function make_random_complists(seed, complist, ncomps, newfilebase, listlength, numfiles)
	float seed	// for random number generator
	str complist	// list of all eligible compartments (file).
	int ncomps	// # compts in complist
	str newfilebase	// base name of new file to be created
	int listlength	// approx. # compartments to include in the list.
			// since it's random, can't guarantee actual #.
	int numfiles	//number of random compartment lists to generate.

	randseed {seed} 
	int n, fnum
	float rnum
	str compname
	str newfile

	for (fnum = 1; fnum <= {numfiles}; fnum = fnum + 1)
		newfile = newfilebase @ "_" @ {fnum} @ ".asc"
		openfile {newfile} w 
		openfile {newfile} a

		//cycle through list of possibilities
		openfile {complist} r 
		for (n = 1; n <= {ncomps}; n = n + 1)
			compname = {readfile {complist}}
		//	echo {compname}
			//select a certain percentage of compartments for output
			rnum = {rand 0 {ncomps}}
		//	echo {rnum}
			if ({rnum} <= {listlength})
				//Include compt
				writefile {newfile} {compname}	
				echo {compname} " added"
			end
		end
		closefile {newfile} 
		closefile {complist}
	end
end
