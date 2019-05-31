//GENESIS utility script for exporting the times of synaptic excitation in the
//	GP neuron model.
// Author: J. Edgerton, 08/2004
// Each timetable gets its own output file. Each file is 1 column of ascii txt.

/*
User must set the following variables before calling write_timetables:
	str outfile = base name of new files to be created.
	str compsfname = ascii file list of names of the compartments from which
		timetables will be saved. 
		e.g.: if saving STN timetables, compsfname would be
			"STN_input_comps.asc"
		      if saving Str timetables, compsfname would be
			"gp1dendritenames.asc"
	str synname = "STN", "striatum", or "pallidum"
	int num_syncomps = number of compartments in the list
*/
	
function write_timetables
	openfile {compsfname} r
	str fname
	str thiscompt
	int n
	int k
	for (n = 1; n <= {num_syncomps}; n = n+1)
		fname = {outfile} @ "_" @ {n} @ ".asc"
		openfile {fname} w
		thiscompt = {readfile {compsfname}}
		ce /inputs/{synname}/{thiscompt}/timetable
		for (k = 0; k <= {getfield ./ maxpos} - 1; k = k+1)
			writefile {fname} {getfield ./ *timetable[{k}]}
		end
		// add one more entry, then start new line.
		closefile {fname}
	end
	closefile {compsfname}
end
	
	
