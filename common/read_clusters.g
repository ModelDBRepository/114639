//FILE IN USE 08/05/2004 -- present.

// script to add channel clusters to GP model without adding synapses.
// clusters are added to compartments read from file {clusterfname}

int i
str clustercomp
int num_cluster = 0
// open file to list compartment names for clusters
openfile {clusterfname} r 
clustercomp = {readfile {clusterfname}}
//cycle through selected compartments
while (! {eof {clusterfname}})

	num_cluster = {num_cluster} + 1
	//get existing channel densities for each compartment
	float Gbar_NaF = {getfield {cellpath}/{clustercomp}/Na_fast_GP Gbar}
	float Gbar_NaP = {getfield {cellpath}/{clustercomp}/Na_slow_GP Gbar}
	float Gbar_Kv2 = {getfield {cellpath}/{clustercomp}/Kv2_GP Gbar}
	float Gbar_Kv3 = {getfield {cellpath}/{clustercomp}/Kv3_GP Gbar}
	float Gbar_Kv4f = {getfield {cellpath}/{clustercomp}/Kv4_fast_GP Gbar}
	float Gbar_Kv4s = {getfield {cellpath}/{clustercomp}/Kv4_slow_GP Gbar}

	//multiply channel densities by cluster values
	setfield {cellpath}/{clustercomp}/Na_fast_GP Gbar \
		{{Gbar_NaF}*{G_mult_Na_cluster}}
	setfield {cellpath}/{clustercomp}/Na_slow_GP Gbar \
		{{Gbar_NaP}*{G_mult_Na_cluster}}
	setfield {cellpath}/{clustercomp}/Kv2_GP Gbar \
		{{Gbar_Kv2}*{G_mult_Kdr_cluster}}
	setfield {cellpath}/{clustercomp}/Kv3_GP Gbar \
		{{Gbar_Kv3}*{G_mult_Kdr_cluster}}
	setfield {cellpath}/{clustercomp}/Kv4_fast_GP Gbar \
		{{Gbar_Kv4f}*{G_mult_KA_cluster}}
	setfield {cellpath}/{clustercomp}/Kv4_slow_GP Gbar \
		{{Gbar_Kv4s}*{G_mult_KA_cluster}}	

	/* diagnostic
	echo {getfield {cellpath}/{clustercomp}/Na_fast_GP Gbar}
	echo {getfield {cellpath}/{clustercomp}/Kv4_fast_GP Gbar}
	echo {getfield {cellpath}/{clustercomp}/Kv4_slow_GP Gbar}
	*/
	
	// get next compartment name
	clustercomp = {readfile {clusterfname}}
end
closefile {clusterfname} 

