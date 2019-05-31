// GENESIS SETUP FILE

// sets pulse amplitude and width
function setpulse (cip_pA, delay, width)
  setfield /pulse		     	\
	level1          {{cip_pA}*1e-12}\
	width1 		{width}	       	\
	delay1          {delay}		\
	delay2          50      	\
	baselevel       0 		\
	trig_mode       0
end

// run a simulation for given cip parameters
function do_cip_run (cip_pA, delay, width, run_dur, cellpath, basefilename, snapshotname)
    str filename_v = {basefilename} @ "_" @ {cip_pA} @ "_pAcip.bin"

    // Exit if data file already exists, assume sim done
    str fileexists = {ls "data/" @ {filename_v}}

    if (fileexists == "0")
       echo "Datafile " {filename_v} " already exists, quitting."
       exit
    end

    // Write to /tmp/
    setfield /out_v filename "/tmp/" @ {filename_v}
    setpulse {cip_pA} {delay} {width}
    
    // Run simulation
    reset
    if ({snapshotname} != "")
	restore {snapshotname}
	call {cellpath} HRESTORE
    end
    step {run_dur} -time

    // File data is not flushed unless the following is done
    setfield /out_v flush 1
    setfield /out_v filename "/tmp/a"
    step 1
    setfield /out_v flush 0
    //rm /tmp/a

    // move from /tmp/ to NFS'd data/
    mv {filename_v} data/
end

silent

//initialize parameters
include ../../common/GP1_defaults.g
include ../../common/simdefaults.g
include ../../common/actpars.g

/* COMMENT
ALL intrinsic model params have now been initialized and set. 
They can be safely overwritten any time between now and the calling of
the make_GP_library file. Once the library has been created, parameter values
are set and cannot be changed except with explicit calls to setfield.
*/

//load variable parameter values from environment variable
if ({getenv GENESIS_PAR_ROW} == "")
  echo "*********************************************************************"
  echo "Error: This script needs to read the parameters from the environment "
  echo "        variable GENESIS_PAR_ROW. Set the variable prior to running"
  echo "        the script. Aborting simulation."
  echo "*********************************************************************"
  quit
end

str parrow = {getenv GENESIS_PAR_ROW}

echo "Parameter row: " {parrow}

int i
str tstr, hstr, readcompartment

// Overwrite the defaults for the following parameters:
G_Na_fast_GP =		{getarg {arglist {parrow}} -arg 1}
G_Na_slow_GP = 		{getarg {arglist {parrow}} -arg 2}
G_Kv2_GP =		{getarg {arglist {parrow}} -arg 3}
G_Kv3_GP =		{getarg {arglist {parrow}} -arg 4}
G_Kv4_fast_GP =		{getarg {arglist {parrow}} -arg 5}
G_Kv4_slow_GP = 	{G_Kv4_fast_GP} * 1.5
G_KCNQ_GP =		{getarg {arglist {parrow}} -arg 6}
G_K_ahp_GP = 		{getarg {arglist {parrow}} -arg 7}
G_Ca_HVA_GP = 		{getarg {arglist {parrow}} -arg 8}
G_h_HCN_GP =		{getarg {arglist {parrow}} -arg 9}
G_h_HCN2_GP = 		{G_h_HCN_GP} * 2.5


// Declare and set external params (not included in GPdefaults).
float trialnum = 	{getarg {arglist {parrow}} -arg 10}

float cip = 0

// Now that all params have been established, create library objects.
//	Intrinsic params should be left alone from this point forward.
include ../../common/make_GP_library.g

//filename based on variable parameters
str basefilename = "brute_" @ {trialnum} @ "_trial"

dt = 1e-5
//set up clocks
setclock 0 {dt}	  	// simulation
setclock 1 {1e-4} 	// output
rundur = 1		// simulation length

//load compartments with ion channels
readcell ../../common/GP1.p {cellpath} -hsolve

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

// Run 1 sec to reach steady state or stable cycle 
// and 1 sec for spontaneous firing with 0 pA cip 
do_cip_run 0 1 1 2 {cellpath} {basefilename}

include ../../common/snapshotGP
snapshotname = "/tmp/brute_"	@	{trialnum}	@	".save"
take_snapshot

do_cip_run -100 0 1 2   {cellpath} {basefilename} {snapshotname}
do_cip_run 50   0 1 0.5 {cellpath} {basefilename} {snapshotname}
do_cip_run 100  0 1 2   {cellpath} {basefilename} {snapshotname}
do_cip_run 200  0 1 0.5 {cellpath} {basefilename} {snapshotname}

rm {snapshotname}
quit
