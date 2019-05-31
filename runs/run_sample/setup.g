// GENESIS SETUP FILE
// Copy and modify this file
// $Id: setup.g,v 1.6 2007/02/26 20:04:16 cengiz Exp $

// Load common CIP functions and default values
include ../../common/CIPfuncs.g

// Modify CIP configuration options
defdatadir = "data"
tmpdir = "data"
destdir = "data"
compressdata = 1
savesnapshot = 0
trialparamnum = 11
create_tmpdir

silent

//load variable parameter values from environment variable
str parrow = {read_env_params}
echo "Parameter row: " {parrow}

str hstr, readcompartment

// assign variables by reading from the parrow variable
include readGPparams.g

// Now that all params have been established, create library objects.
//	Intrinsic params should be left alone from this point forward.
include ../../common/make_GP_library.g

dt = 1e-5
//set up clocks
setclock 0 {dt}	  	// simulation
setclock 1 {1e-4} 	// output
rundur = 1		// simulation length

//load compartments with ion channels
readcell {"../../common/" @ {morph_name} @ ".p"} {cellpath} -hsolve

//set up current injection
create pulsegen /pulse
addmsg /pulse {cellpath}/soma INJECT output

//set up hines solver
setfield {cellpath} 				\
	path {cellpath}/##[][TYPE=compartment] 	\
        comptmode       1 			\
        chanmode        3 			\
        calcmode        0 			\
        outclock        1 			\
        storemode       0
call {cellpath} SETUP
setmethod 11
		
//add synapses to appropriate compartments	
//include ../../common/read_STN_syns_nocluster
include ../../common/read_clusters
//include ../../common/read_striatum_syns_const_scaled
//include ../../common/add_pallidum_syns

// Do each cip run serially

// Start saving voltage data
create disk_out /out_v
useclock /out_v 1
setfield /out_v flush 0 append 0 leave_open 1
hstr = {findsolvefield {cellpath} {cellpath}/soma Vm}
addmsg {cellpath} /out_v SAVE {hstr}

include ../../common/snapshotGP

str snapshotname = "/brute_"	@	{trialnum}	@	".save"
str defsnapshot = {defdatadir} @ {snapshotname}

fileexists = {ls {defsnapshot}}

if (fileexists != "0")
  // doesn't exist, run spont sim, and take snapshot
  // Run 1 sec to reach steady state or stable cycle 
  // and 1 sec for spontaneous firing with 0 pA cip 
  do_cip_run 0 1 1 2 {cellpath} {trialnum}  
  snapshotname = {tmpdir} @ {snapshotname}
  take_snapshot
else
  // exists
  // If snapshot is in data/, first copy to /tmp/ and then use
  cp {{defdatadir} @ {snapshotname}} {tmpdir}
  snapshotname = {tmpdir} @ {snapshotname}
  // still run the simulation unless the voltage trace also exists
  do_cip_run 0 1 1 2 {cellpath} {trialnum}  
end

// Run CIP simulations starting from snapshot point
do_cip_run -100 0 1 2   {cellpath} {trialnum} {snapshotname}
do_cip_run 40   0 1 0.5 {cellpath} {trialnum} {snapshotname}
do_cip_run 100  0 1 2   {cellpath} {trialnum} {snapshotname}
do_cip_run 200  0 1 0.5 {cellpath} {trialnum} {snapshotname}

// No need to save snapshot. takes too much space and wastes time.
if (savesnapshot != 0)
  time mv {snapshotname} {destdir}
//  rm {snapshotname}
end
quit
