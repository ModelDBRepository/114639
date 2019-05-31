//GPdefaults - set default param values for GP simulations.
//	Any param value can be overwritten subsequently.
// THIS VERSION CURRENT 06/25/2004 to present.
// Modified 08/02/2004: add filename strings to this file, remove them from
//	other files (read_STN_syns_Kv.g, add_striatum_syns.g)

str snapshot_act = "../../common/gp4_act_spont_snapshot.save"
str snapshot_pas = "../../common/gp4_pas_spont_snapshot.save"

str allcompsfilename 	= "../../common/gp4allcompnames.asc"
int ncomps 			= 643	// total # compartments in model. 
					// Keep this up to date!

str dendfilename 	= "../../common/gp4dendritenames.asc"
int num_dendcomps 		= 541	// total # dendritic compartments

str outputcompsfname 	= "../../common/gp4outputnames.asc"
int num_outputcomps 		= 18	// # compts listed in output_compnames

str STNfilename 	= "../../common/gp4_stn/gp4stn_1.asc"
int num_STN			= 100	// # STN inputs

str clusterfname 	= {STNfilename}
int num_clusters 		= 100	// # compts receiving clusters
float mean_cluster_level	= 6   	// overall cluster level to maintain
float G_mult_Na_cluster       	= 6 	// Na cluster level at synapse subset
float G_mult_Kdr_cluster 	= 6	// Kdr cluster level at same synapses
float G_mult_KA_cluster		= 1

str striatumfname 	= "../../common/gp4dendritenames.asc"
int num_striatum_compts 	= 541
int num_striatum_per_comp 	= 2

float num_pallidal		= 10	// all in soma


float PI = 3.14159

//Passive properties
float RA = 1.74		// uniform
float CM = 0.024	// all unmyelinated regions
float CM_my = 0.00024	// myelinated axon segments.
float RM_sd = 1.47 	// soma
float RM_ax = {RM_sd}	// unmyelinated axonal regions
float RM_my = 10	// myelinated axon segments.
float ELEAK_sd  = -0.060	// soma & dend
float ELEAK_ax	= -0.060	// axon
float EREST_ACT = -0.060

/* Channel densities now set in either actpars.g or paspars.g for
	active or passive model.
*/

