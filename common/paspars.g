//paspars - set conductance densities for the spiking dendrite model
//	Any param value can be overwritten subsequently.
// THIS VERSION CURRENT 04/25/2005 to present.

str snapshotname = {snapshot_pas}

//Voltage-gated ion channel densities
float G_Na_fast_GP  = 500 	 
float G_Na_slow_GP  = 0.5
float G_Kv3_GP  	= 30
float G_Kv2_GP  	= 3 	
float G_Kv4_fast_GP = 5 
float G_Kv4_slow_GP = {G_Kv4_fast_GP}*1.5
float G_KCNQ_GP 	= 0.1
float G_Ca_HVA_GP   = 1	
float G_K_ahp_GP    = 17
float G_h_HCN_GP    = 3
float G_h_HCN2_GP   = {G_h_HCN_GP}/1.5

//Multipliers for conductance densities
float G_mult 			= 1
float G_mult_Na_dend   	= 0
float G_mult_Kdr_dend  	= 0
float G_mult_KA_dend   	= 2
float G_mult_KCNQ_dend	= 1
float G_mult_SK_dend	= 0.04
float G_mult_Ca_dend 	= 1
float G_mult_HCN_dend	= 1
float G_mult_Na_soma    = 25 
float G_mult_Kdr_soma   = 18.5 
float G_mult_KA_soma    = 1
float G_mult_KCNQ_soma	= 1
float G_mult_SK_soma	= 1
float G_mult_Ca_soma	= 1
float G_mult_Na_axon 	= 40
float G_mult_Kdr_axon 	= 40
float G_mult_KA_axon 	= 40
float G_mult_KCNQ_axon	= 40

