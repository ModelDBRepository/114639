//FILE IN USE 05/24/2004 -- 08/10/2004
//Modified 06/28/2004: Kv4f and Kv4s clusters added.
// Modified 08/04/2004: if statements for STN_rate == 0 condition added.

/*script to add synapses to GP model*/

randseed 78923456 
int i
float d,l,surf
str stncompartment
// Be aware that path must be absolute or else relative to the RUN DIRECTORY,
//	not the directory in which this file (read_STN_syns_Kv.g) is located.

//create input element tree outside of the cell path
if (!{exists /inputs})
	create neutral /inputs
end
create neutral /inputs/STN

//clear and open file to list compartment names of all excitatory synapses
openfile {STNfilename} r 
//cycle through STN input compartments
for (i = 1; i <= {num_STN}; i = i + 1)
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

	//get existing channel densities for each compartment
	float Gbar_NaF = {getfield {cellpath}/{stncompartment}/Na_fast_GP Gbar}
	float Gbar_NaP = {getfield {cellpath}/{stncompartment}/Na_slow_GP Gbar}
	float Gbar_Kv2 = {getfield {cellpath}/{stncompartment}/Kv2_GP Gbar}
	float Gbar_Kv3 = {getfield {cellpath}/{stncompartment}/Kv3_GP Gbar}
	float Gbar_Kv4f = {getfield {cellpath}/{stncompartment}/Kv4_fast_GP Gbar}
	float Gbar_Kv4s = {getfield {cellpath}/{stncompartment}/Kv4_slow_GP Gbar}


	/* for testing purposes
	float gnafb = {G_Na_fast_GP}*surf*{G_mult_Na_dend}*{G_mult_Na_cluster}
	float gnapb = {G_Na_slow_GP}*surf*{G_mult_Na_dend}*{G_mult_Na_cluster}
	float gkv2b = {G_Kv2_GP}*surf*{G_mult_Kdr_dend}*{G_mult_Kdr_cluster}
	float gkv3b = {G_Kv3_GP}*surf*{G_mult_Kdr_dend}*{G_mult_Kdr_cluster}
	echo {gnaf}	{gnafb}
	echo {gnap}	{gnapb}
	echo {gkv2}	{gkv2b}
	echo {gkv3}	{gkv3b}
	*/
	
	//multiply channel densities by cluster values
	setfield {cellpath}/{stncompartment}/Na_fast_GP Gbar \
		{{Gbar_NaF}*{G_mult_Na_cluster}}
	setfield {cellpath}/{stncompartment}/Na_slow_GP Gbar \
		{{Gbar_NaP}*{G_mult_Na_cluster}}
	setfield {cellpath}/{stncompartment}/Kv2_GP Gbar \
		{{Gbar_Kv2}*{G_mult_Kdr_cluster}}
	setfield {cellpath}/{stncompartment}/Kv3_GP Gbar \
		{{Gbar_Kv3}*{G_mult_Kdr_cluster}}
	setfield {cellpath}/{stncompartment}/Kv4_fast_GP Gbar \
		{{Gbar_Kv4f}*{G_mult_KA_cluster}}
	setfield {cellpath}/{stncompartment}/Kv4_slow_GP Gbar \
		{{Gbar_Kv4s}*{G_mult_KA_cluster}}	

	/*
	//Add clusters explicitly
	//This is risky because changes made at the GPcomps level (such as new
	//	multipliers or modifiers) are not taken into account.
	setfield {cellpath}/{stncompartment}/Na_fast_GP Gbar \
		{{G_Na_fast_GP}*surf*{G_mult_Na_dend}*{G_mult_Na_cluster}}
	setfield {cellpath}/{stncompartment}/Na_slow_GP Gbar \
		{{G_Na_slow_GP}*surf*{G_mult_Na_dend}*{G_mult_Na_cluster}}
	setfield {cellpath}/{stncompartment}/Kv2_GP Gbar \
		{{G_Kv2_GP}*surf*{G_mult_Kdr_dend}*{G_mult_Kdr_cluster}}
	setfield {cellpath}/{stncompartment}/Kv3_GP Gbar \
		{{G_Kv3_GP}*surf*{G_mult_Kdr_dend}*{G_mult_Kdr_cluster}}
	*/

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
end
closefile {STNfilename} 
