//FILE IN USE 08/05/2004 -- present.

/*script to add synapses to GP model {stncompartment}*/

randseed 78923456 
int i
float d,l,surf

//create input element tree outside of the cell path
if (!{exists /inputs})
	create neutral /inputs
end
create neutral /inputs/STN

str stncompartment = "soma"

//Add AMPA synapses to {stncompartment}
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

//create input compartment object
create neutral /inputs/STN/{stncompartment}

//set up timetables & spikegens
int n
for (n = 1; n <= {num_STN}; n = n+1)
	create timetable /inputs/STN/{stncompartment}/timetable[{n}]
	if ({STN_rate} > 0)
		setfield /inputs/STN/{stncompartment}/timetable[{n}]	\
			maxtime 200 act_val 1.0 method 2 		\
			meth_desc1 {1/{STN_rate}} 			\ 
			meth_desc2 0.005 				\ 
			meth_desc3 3	
		call /inputs/STN/{stncompartment}/timetable[{n}] TABFILL
	end
	
	//set up spikegen
	create spikegen /inputs/STN/{stncompartment}/spikegen[{n}]
	setfield /inputs/STN/{stncompartment}/spikegen[{n}]		\
		output_amp 1 thresh 0.5
	//connect timetables to AMPA synapses
	if ({STN_rate} > 0)
       		addmsg /inputs/STN/{stncompartment}/timetable[{n}] 	\
       			/inputs/STN/{stncompartment}/spikegen[{n}]	\
			INPUT activation
       		addmsg /inputs/STN/{stncompartment}/spikegen[{n}] 	\
       			{cellpath}/{stncompartment}/AMPA SPIKE
	end
end

