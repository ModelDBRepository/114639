/* randomly jitter synapse timetables*/

function add_jitter(synname, compsfname, ncomps, seednum)
	int ncomps, seednum, n, seed
	str synname		// "STN", "striatum" or "pallidum"
	str compsfname	// file name--> compartment list
	float this_iti
	openfile "../../common/randseeds.asc" r
	openfile {compsfname} r
	str cname
	int num_syns

//	echo "synname: " {synname}
//	echo "compsfname: " {compsfname}
//	echo "ncomps: "	{ncomps}
//	echo "seednum: " {seednum}
	
	for (n = 1; n <= seednum; n = n+1)
		seed = {readfile {"../../common/randseeds.asc"}}
	end
	
	randseed {seed}

	for (n = 1; n <= ncomps; n = n+1)
		cname = {readfile {compsfname}}
		this_iti = {getfield /inputs/{synname}/{cname}/timetable meth_desc1}
		call /inputs/{synname}/{cname}/timetable TUPDATE 1 0 {rundur} {this_iti}
	end
end
