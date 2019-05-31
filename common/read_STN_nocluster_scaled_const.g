// FILE IN USE 10/12/2004 -- present

/*
Script to add synapses to GP model but not add channel clusters. Clusters
are handled separately by the read_clusters.g file. Clusters are added to
the compartments listed in {clusterfname}, while STN synapses are added to the
compartments listed in {STNfilename}. GP$1_defaults has these two set to the same,
so the default is to have clusters at all STN synapse locations. Users can
overwrite either or both file names to change the locations of syns & clusters.
STN synapse amplitudes are scaled according to the values in {STN_scale}
*/

randseed 78923456 
int i, num
float d,l,surf 
float scalefac, totscale, meanscale
float Rmemb, Ememb, nspikes, ginteg, gsyn, gcompt
str stncompartment

include ../../common/calc_syn_integ.g

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

echo "totscale: " {totscale}
echo "num: " {num}
echo "meanscale: " {meanscale}

//clear and open file to list compartment names of all excitatory synapses
//	File MUST NOT have any blank lines at the end, or function will fail.
openfile {STNfilename} r
stncompartment = {readfile {STNfilename}}
openfile {STN_scale} r
scalefac = {readfile {STN_scale}}

//cycle through STN input compartments
while (! {eof {STNfilename}})

	num_STN = {num_STN} + 1

	//get compartment parameters 
	d = {getfield {cellpath}/{stncompartment} dia}
	l = {getfield {cellpath}/{stncompartment} len}
	surf = {d}*{l}*{PI}
	Rmemb = {getfield {cellpath}/{stncompartment} Rm}
	Ememb = {getfield {cellpath}/{stncompartment} Em}
	
	//set up timetable
	create neutral /inputs/STN/{stncompartment}
	create timetable /inputs/STN/{stncompartment}/timetable
	if ({STN_rate} > 0)
		setfield /inputs/STN/{stncompartment}/timetable		\
			maxtime {rundur} act_val 1.0 method 2 		\
			meth_desc1 {1/{STN_rate}} meth_desc2 0.005 meth_desc3 3	
		call /inputs/STN/{stncompartment}/timetable TABFILL
	end

	// count # synaptic events in timetable
	// NOTE that the duration of the run must be set by the parameter {rundur}
	//	or else the # of events will be incorrect and the conductance won't
	//	be set correctly.
	nspikes = {getfield /inputs/STN/{stncompartment}/timetable maxpos}

	// calculate total synaptic conductance integral for run, scaled.
	ginteg = {nspikes}*{calc_syn_integ \
		{{G_AMPA}*{scalefac}/{meanscale}} {tauRise_AMPA} {tauFall_AMPA}}

	// calculate mean invariant conductance level using run duration
	gsyn = {{ginteg}/{rundur}}

	// determine new values for compartment Rm and Em
	gcompt = 1/{Rmemb}
	setfield {cellpath}/{stncompartment} Rm {1/({gcompt} + {gsyn})}
	setfield {cellpath}/{stncompartment} Em	\
		{{Ememb} + ({E_AMPA} - {Ememb})*({gsyn}/({gcompt} + {gsyn}))}

	// diagnostic
	echo {stncompartment} "Rm was: " {Rmemb}
	echo "Rm is now: " {getfield {cellpath}/{stncompartment} Rm}
	echo "Em was: " {Ememb}
	echo "Em is now: " {getfield {cellpath}/{stncompartment} Em}

	// get next compartment name
	stncompartment = {readfile {STNfilename}}
	scalefac = {readfile {STN_scale}}
	if ({eof {STN_scale}})
		echo "eof scale"
	end
end
closefile {STNfilename}
closefile {STN_scale}

if ({num_STN} != {num})
	echo "ERROR: number of scale factors doesn't match number of synapses."
	quit
end
