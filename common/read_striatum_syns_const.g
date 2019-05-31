// Genesis script to substitute constant membrane conductance for GABA chans.
// Author: J. Edgerton, 08/2004

randseed 78123456 
int i
str striatumcompartment
float d,l,surf,Rmemb,Ememb
float nspikes,ginteg,gsyn,gcompt

include ../../common/calc_syn_integ.g

//create input element tree outside of the cell path
if (!{exists /inputs})
	create neutral /inputs
end
create neutral /inputs/striatum

//cycle through each dendritic compartment
openfile {striatumfname} r
for (i = 1; i <= {num_striatum_compts}; i = i + 1)
        striatumcompartment = {readfile {striatumfname}}

	// get compt params
	d = {getfield {cellpath}/{striatumcompartment} dia}
	l = {getfield {cellpath}/{striatumcompartment} len}
	surf = {PI}*{d}*{l}
	Rmemb = {getfield {cellpath}/{striatumcompartment} Rm}
	Ememb = {getfield {cellpath}/{striatumcompartment} Em}

	// set up timetable
	create neutral /inputs/striatum/{striatumcompartment}
        create timetable /inputs/striatum/{striatumcompartment}/timetable 
	if ({striatum_rate} > 0)
		setfield /inputs/striatum/{striatumcompartment}/timetable \
                     maxtime {rundur} act_val 1.0 method 2		\
                     meth_desc1 {1/{{striatum_rate}*{num_striatum_per_comp}}} \
		     meth_desc2 0 meth_desc3 3
        	call /inputs/striatum/{striatumcompartment}/timetable TABFILL
	end
	
	// count # synaptic events in timetable
	// NOTICE: the # events assumes that the duration of the run is
	//	set by the parameter {rundur}.
	nspikes = {getfield	\
		/inputs/striatum/{striatumcompartment}/timetable maxpos}
	
	// calculate total synaptic conductance integral for run
	ginteg = {nspikes}*{calc_syn_integ	\
		{G_GABA} {tauRise_GABA} {tauFall_GABA}}
	
	// calculate mean invariant conductance level
	gsyn = {ginteg}/{rundur}
	
	// determine new values for compartment Rm and Em
	gcompt = 1/{Rmemb}
//	echo "gsyn: " {gsyn} "gcompt: " {gcompt}
	setfield {cellpath}/{striatumcompartment} Rm {1/({gcompt} + {gsyn})}
	setfield {cellpath}/{striatumcompartment} Em	\
		{{Ememb} + ({E_GABA} - {Ememb})*({gsyn}/({gcompt} + {gsyn}))}
	
	// diagnostic
/*
	echo "Rm was: " {Rmemb}
	echo "Rm is now: " {getfield {cellpath}/{striatumcompartment} Rm}
	echo "Em was: " {Ememb}
	echo "Em is now: " {getfield {cellpath}/{striatumcompartment} Em}
*/
end
closefile {striatumfname}
