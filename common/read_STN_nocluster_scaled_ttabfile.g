// FILE IN USE 05/09/2005 -- present

/*
Add AMPA synapses to compartments listed in {STNfilename}, scale each
according to {STN_scale} and read timetables from files.
*/

int i, num
float d,l,surf, scalefac, totscale, meanscale
str stncompartment, tabfile

//create input element tree outside of the cell path
if (!{exists /inputs})
	create neutral /inputs
end
create neutral /inputs/STN

num_STN = 0

// Get mean value of scale factors
openfile {STN_scale} r
scalefac = {readfile {STN_scale}}
totscale = 0
num = 0

while (! {eof {STN_scale}})
	totscale = {totscale} + {scalefac}
	num = {num} + 1
	scalefac = {readfile {STN_scale}}
end

closefile {STN_scale}

meanscale = {totscale} / {num}

//echo "totscale: " {totscale}
//echo "num: " {num}
//echo "meanscale: " {meanscale}

//clear and open file to list compartment names of all excitatory synapses
//	File MUST NOT have any blank lines at the end, or function will fail.
openfile {STNfilename} r
stncompartment = {readfile {STNfilename}}
openfile {STN_scale} r
scalefac = {readfile {STN_scale}}

//cycle through STN input compartments
while (! {eof {STNfilename}})

	num_STN = {num_STN} + 1
//	echo {num_STN}
//	echo {stncompartment}
//	echo {scalefac}
	tabfile = {ttab_filebase}	@	{num_STN}	@	".asc"
	//Add AMPA synapses
	copy /library/AMPA {cellpath}/{stncompartment}/AMPA
	addmsg  {cellpath}/{stncompartment}/AMPA \
		{cellpath}/{stncompartment} CHANNEL Gk Ek
	addmsg  {cellpath}/{stncompartment} \
		{cellpath}/{stncompartment}/AMPA VOLTAGE Vm

	// scale synapse amplitude
	setfield {cellpath}/{stncompartment}/AMPA gmax {{G_AMPA}*{scalefac}/{meanscale}}
//	echo "synapse " {stncompartment} ": " {getfield {cellpath}/{stncompartment}/AMPA gmax}
	//set up timetables
	create neutral /inputs/STN/{stncompartment}
	create timetable /inputs/STN/{stncompartment}/timetable
	setfield /inputs/STN/{stncompartment}/timetable		\
		maxtime {rundur} act_val 1.0 method 4 fname {tabfile}
		call /inputs/STN/{stncompartment}/timetable TABFILL
	
	//set up spikegen
	create spikegen /inputs/STN/{stncompartment}/spikegen
    setfield /inputs/STN/{stncompartment}/spikegen 			\
		output_amp 1 thresh 0.5

	//connect timetables to AMPA synapses
	addmsg /inputs/STN/{stncompartment}/timetable \
		/inputs/STN/{stncompartment}/spikegen INPUT activation
	addmsg /inputs/STN/{stncompartment}/spikegen \
		{cellpath}/{stncompartment}/AMPA SPIKE
	
	// get next compartment name
	stncompartment = {readfile {STNfilename}}
	if (! {eof {STNfilename}})
		scalefac = {readfile {STN_scale}}
	end
end
closefile {STNfilename}
closefile {STN_scale}

if ({num_STN} != {num})
	echo "ERROR: number of scale factors doesn't match number of synapses."
	quit
end
