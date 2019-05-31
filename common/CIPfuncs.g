// ************************************************************
// Common functions to be used in CIP-injection experiments.
// See bottom for out-of-function commands.
// ---
// Made into function form with added logics by C. Gunay, 2006/01/25
// ************************************************************

// Initialize defaults
include ../../common/simdefaults.g

// Configuration options that can be overridden in the setup script
// ----------------------------------------------------------------------

// Where data files normally reside
str defdatadir = "data"

// Temporary directory where data files are created.
// Can improve speed if network drives are avoided during simulation.
str tmpdir = "/var/tmp"

// Move files to this destination, can have host names like "work00:run/data"
str destdir = "data"  

// Whether or not to compress data files
int compressdata = 0

// Whether or not to save the snapshot image
int savesnapshot = 0

// Whether or not to save Itotal array
int saveItotal = 0

// Snapshotname
str snapshotname

// Sequence number of the trial parameter 
int trialparamnum = 11

// ----------------------------------------------------------------------
// end of configuration options

// temp variables
str fileexists

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

// Compresses data file and returns new file name.
// If fails, returns original filename.
function compress_data_file (raw_filename)
  str comp_filename={strsub {raw_filename} .bin .genflac}
  // TODO: check if 86-84 architecture
  str success = {sh convertgenesis16bit-x86_64 {raw_filename} {comp_filename}}
  if ({success} == "0")
    // successfully compressed file
    rm {raw_filename}
    return {comp_filename}
  else
    echo "*** Warning: Failed to compress data file " @ {raw_filename} @ "."
    return {raw_filename}
  end
end

// run a simulation for given cip parameters
function do_cip_run (cip_pA, delay, width, run_dur, cellpath, basefilename, snapshotname)
  str file_ext
  
  str filename_stem = {basefilename} @ "_" @ {cip_pA} @ "_pAcip"
  str filename_v = {filename_stem} @ ".bin"
  str filename_itot = {filename_stem} @ "_g" @ ".bin"
  
  // Exit if data file already exists, assume sim done
    str deffilename = {defdatadir} @ {filename_v}

    str checkfilename

    if ({compressdata} != 0)
      checkfilename = {defdatadir} @ {filename_stem} @ ".genflac"
    else
      checkfilename = {defdatadir} @ {filename_stem} @ ".bin"
    end
    fileexists = {ls {checkfilename}}

    if ({fileexists} == "0")
      echo "*** Warning: Datafile " {filename_v} " already exists, skipping."
      echo "    Remove it and rerun the simulation if you want it recreated."
      return
    end

    // Write to file
    str deffilename = {tmpdir} @ {filename_v}
    str deffilename_itot = {tmpdir} @ {filename_itot}

    // Write voltage trace
    setfield /out_v filename {deffilename}
    setpulse {cip_pA} {delay} {width}

    if ({saveItotal} != 0)
      // Write total currents
      setfield /out_Itot filename {deffilename_itot} 
    end
    
    // Run simulation
    reset
    if ({snapshotname} != "")
	restore {snapshotname}
	call {cellpath} HRESTORE
    end
    step {run_dur} -time

    // File data is not flushed unless the following is done
    setfield /out_v flush 1
    setfield /out_v filename "/var/tmp/a"
    step 1
    setfield /out_v flush 0
    //rm /tmp/a

    if ({saveItotal} != 0)
      setfield /out_Itot flush 1
      setfield /out_Itot filename "/var/tmp/a"
      step 1
      setfield /out_Itot flush 0
    end

    if ({compressdata} != 0)
      // compress data file
      deffilename = {compress_data_file {deffilename}}
      if ({saveItotal} != 0)
	deffilename_itot = {compress_data_file {deffilename_itot}}
      end
    end

    // Copy file from temporary location to desired location
    fileexists = {time mv {deffilename} {destdir}}

    if ({fileexists} == "0")
      // Remove original data file only if copy was successful
      //rm {deffilename}
    end
end

function create_tmpdir
  // create tmpdir, if missing
    fileexists = {mkdir {tmpdir}}

    //echo "exit status: " @ {fileexists}
    
    /*if (fileexists != "0")
      echo "Error creating directory " @ {tmpdir}
      quit
    end
    */
end

// Cleanup and finish CIP experiment
function cip_finish
  // No need to save snapshot. takes too much space and wastes time.
  if (savesnapshot != 0)
    mv {snapshotname} {destdir}
  else
    rm {snapshotname}
  end
  quit
end

function cip_init
  // Start saving voltage data
  create disk_out /out_v
  useclock /out_v 1
  setfield /out_v flush 0 append 0 leave_open 1
  str hstr = {findsolvefield {cellpath} {cellpath}/soma Vm}
  addmsg {cellpath} /out_v SAVE {hstr}

  if ({saveItotal} != 0)
    // For saving current data
      create disk_out /out_Itot
      useclock /out_Itot 1
      setfield /out_Itot flush 0 append 0 leave_open 1
      // Itotal array
      int i
      for (i=1; i<=15; i=i+1)
	addmsg {cellpath} /out_Itot SAVE itotal[{i}]
      end
  end

  create_tmpdir
end

// function to read variable parameter values from environment variable
function read_env_params
  str parrow = {getenv GENESIS_PAR_ROW}

  if ({parrow} == "")
    echo "*********************************************************************"
    echo "Error: This script needs to read the parameters from the environment "
    echo "        variable GENESIS_PAR_ROW. Set the variable prior to running"
    echo "        the script. Aborting simulation."
    echo "*********************************************************************"
    quit
  end

  return {parrow}
end

