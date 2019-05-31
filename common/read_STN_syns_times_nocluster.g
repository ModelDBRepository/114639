// FILE IN USE 08/10/2004 -- present

/*
Script to add synapses but not channel clusters, and read timetables from file. Clusters are now handled separately by the read_clusters.g file. 
Clusters are added to the compartments listed in {clusterfname}, 
while STN synapses are added to the compartments listed in {STNfilename}. 
GPdefaults has these two set to the same, so the default is to have clusters at all STN synapse locations. 
Users can overwrite either or both file names to change the locations of syns & clusters.

Variables that must be set ahead of time:
	{STNfilename}
	{num_STN}
	{STNtimefile}
*/

int n
float d,l,surf
str timefile
str stncompartment

//create input element tree outside of the cell path
if (!{exists /inputs})
	create neutral /inputs
end
create neutral /inputs/STN

//clear and open file to list compartment names of all excitatory synapses
openfile {STNfilename} r 
//cycle through STN input compartments
for (n = 1; n <= {num_STN}; n = n + 1)
	timefile = {STNtimefile} @ "_" @ {n} @ ".asc"
	stncompartment = {readfile {STNfilename}}

	//Add AMPA synapses
	copy /library/AMPA {cellpath}/{stncompartment}/AMPA
	addmsg  {cellpath}/{stncompartment}/AMPA \
		{cellpath}/{stncompartment} CHANNEL Gk Ek
	addmsg  {cellpath}/{stncompartment} \
		{cellpath}/{stncompartment}/AMPA VOLTAGE Vm

	//get compartment parameters 
	d = {getfield {cellpath}/{stncompartment} dia}
	l = {getfield {cellpath}/{stncompartment} len}
	surf = {d}*{l}*{PI}
        setfield {cellpath}/{stncompartment}/AMPA gmax {G_AMPA}

	// read timetables from file.
	create neutral /inputs/STN/{stncompartment}
	create timetable /inputs/STN/{stncompartment}/timetable
//	if ({STN_rate} > 0)
		setfield /inputs/STN/{stncompartment}/timetable		\
			act_val 1.0 method 4 maxtime {rundur} fname {timefile}
			call /inputs/STN/{stncompartment}/timetable TABFILL
//	end
	//set up spikegen
	create spikegen /inputs/STN/{stncompartment}/spikegen
        setfield /inputs/STN/{stncompartment}/spikegen 			\
		output_amp 1 thresh 0.5
        //connect timetables to AMPA synapses
//	if ({STN_rate} > 0)
        	addmsg /inputs/STN/{stncompartment}/timetable \
        		/inputs/STN/{stncompartment}/spikegen INPUT activation
        	addmsg /inputs/STN/{stncompartment}/spikegen \
        		{cellpath}/{stncompartment}/AMPA SPIKE
//	end
end
closefile {STNfilename} 
