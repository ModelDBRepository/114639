// Modified 08/04/2004: if statements for striatum_rate == 0 condition added.
/*script to add synapses to GP model*/

randseed 78123456 
int i
float d,l,surf
str striatumcompartment = "soma"

//create input element tree outside of the cell path
if (!{exists /inputs})
	create neutral /inputs
end
create neutral /inputs/striatum

float ave_comp = 0

copy /library/GABA {cellpath}/{striatumcompartment}/GABA
addmsg  {cellpath}/{striatumcompartment}/GABA \
        {cellpath}/{striatumcompartment} CHANNEL Gk Ek
addmsg  {cellpath}/{striatumcompartment} \
        {cellpath}/{striatumcompartment}/GABA VOLTAGE Vm

create neutral /inputs/striatum/{striatumcompartment}

//set up timetables & spikegens
//	have separate timetable for each dendritic compartment, but have
//	the 2 striatal inputs to each compartment share a timetable, same as
//	for the normal simulations.
for (n = 1; n <= {num_striatum_compts}; n = n+1)
	create timetable /inputs/striatum/{striatumcompartment}/timetable[{n}] 
	if ({striatum_rate} > 0)
		setfield /inputs/striatum/{striatumcompartment}/timetable[{n}] \
             	    maxtime {rundur} act_val 1.0 method 2		\
             	    meth_desc1 {1/{{striatum_rate}*{num_striatum_per_comp}}} \
	     	    meth_desc2 0 					\ 
		    meth_desc3 3
       		call /inputs/striatum/{striatumcompartment}/timetable[{n}] \ 
			TABFILL
	end
	
	create spikegen /inputs/striatum/{striatumcompartment}/spikegen[{n}]
	setfield /inputs/striatum/{striatumcompartment}/spikegen[{n}]	\
		output_amp 1 thresh 0.5
	//connect timetables to GABA synapses
	if ({striatum_rate} > 0)
        	addmsg /inputs/striatum/{striatumcompartment}/timetable[{n}] \
			/inputs/striatum/{striatumcompartment}/spikegen[{n}] \
			INPUT activation
        	addmsg /inputs/striatum/{striatumcompartment}/spikegen[{n}] \
			{cellpath}/{striatumcompartment}/GABA SPIKE
	end
end
