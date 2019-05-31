// In use 08/06/2004 -- present
/* The following params must be set prior to calling this file:
	str striatumfname: file name of compartments to get striatal inputs
	int num_striatum_compts: number of compartments to get striatal inputs
	int num_striatum_per_comp: # striatal syns per selected compartment.

   All are currently initialized and set in GPdefaults.g, but can be
   overwritten as needed.
*/

randseed 78123456 
int i
float d,l,surf
str striatumcompartment

//create input element tree outside of the cell path
if (!{exists /inputs})
	create neutral /inputs
end
create neutral /inputs/striatum

float ave_comp = 0

//cycle through each dendritic compartment
openfile {striatumfname} r
str striatumcompartment
for (i = 1; i <= {num_striatum_compts}; i = i + 1)
        striatumcompartment = {readfile {striatumfname}}
        copy /library/GABA {cellpath}/{striatumcompartment}/GABA
        addmsg  {cellpath}/{striatumcompartment}/GABA \
                {cellpath}/{striatumcompartment} CHANNEL Gk Ek
        addmsg  {cellpath}/{striatumcompartment} \
                {cellpath}/{striatumcompartment}/GABA VOLTAGE Vm

	//set up timetables  
	create neutral /inputs/striatum/{striatumcompartment}
        create timetable /inputs/striatum/{striatumcompartment}/timetable 
	if ({striatum_rate} > 0)
		setfield /inputs/striatum/{striatumcompartment}/timetable \
                     maxtime {rundur} act_val 1.0 method 2		\
                     meth_desc1 {1/{{striatum_rate}*{num_striatum_per_comp}}} \
		     meth_desc2 0 meth_desc3 3
        	call /inputs/striatum/{striatumcompartment}/timetable TABFILL
	end
	
	//set up spikegen
        create spikegen /inputs/striatum/{striatumcompartment}/spikegen
        setfield /inputs/striatum/{striatumcompartment}/spikegen	\
		output_amp 1 thresh 0.5
        //connect timetables to GABA synapses
	if ({striatum_rate} > 0)
           addmsg /inputs/striatum/{striatumcompartment}/timetable	\
		/inputs/striatum/{striatumcompartment}/spikegen INPUT activation
           addmsg /inputs/striatum/{striatumcompartment}/spikegen	\
		{cellpath}/{striatumcompartment}/GABA SPIKE
	end
end
closefile {striatumfname}
