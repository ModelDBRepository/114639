// FILE IN USE 08/10/2004 -- present

/*
Script to add synapses to GP model but not add channel clusters. Clusters
are now handled separately by the read_clusters.g file. Clusters are added to
the compartments listed in {clusterfname}, while STN synapses are added to the
compartments listed in {STNfilename}. GPdefaults has these two set to the same,
so the default is to have clusters at all STN synapse locations. Users can
overwrite either or both file names to change the locations of syns & clusters.
*/

randseed 78923456 
int i
float d,l,surf
str stncompartment

//create input element tree outside of the cell path
if (!{exists /inputs})
	create neutral /inputs
end
create neutral /inputs/STN

num_STN = 0

//clear and open file to list compartment names of all excitatory synapses
//	File MUST NOT have any blank lines at the end, or function will fail.
openfile {STNfilename} r
stncompartment = {readfile {STNfilename}}
//cycle through STN input compartments
while (! {eof {STNfilename}})

	num_STN = {num_STN} + 1
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

	//set up timetables
	create neutral /inputs/STN/{stncompartment}
	create timetable /inputs/STN/{stncompartment}/timetable
	if ({STN_rate} > 0)
		setfield /inputs/STN/{stncompartment}/timetable		\
			maxtime {rundur} act_val 1.0 method 2 		\
			meth_desc1 {1/{STN_rate}} meth_desc2 0.005 meth_desc3 3	
		call /inputs/STN/{stncompartment}/timetable TABFILL
	end
	//set up spikegen
	create spikegen /inputs/STN/{stncompartment}/spikegen
        setfield /inputs/STN/{stncompartment}/spikegen 			\
		output_amp 1 thresh 0.5
        //connect timetables to AMPA synapses
	if ({STN_rate} > 0)
        	addmsg /inputs/STN/{stncompartment}/timetable \
        		/inputs/STN/{stncompartment}/spikegen INPUT activation
        	addmsg /inputs/STN/{stncompartment}/spikegen \
        		{cellpath}/{stncompartment}/AMPA SPIKE
	end
	
	// get next compartment name
	stncompartment = {readfile {STNfilename}}
end
closefile {STNfilename}
