#! /bin/bash
if [ -z $1 ]; then 
  echo "Usage: "
  echo "	$0 starting_trial_number"
  echo
  echo "Checks if all CIP trace files exist with given trial number + 19683 files."
  exit
fi

start_from=$1
for ((i=$start_from; $i < $[ $start_from + 19683]; i=$[ $i + 1])); do 
	for j in -100 0 40 100 200; do
		file=data/brute_${i}_trial_${j}_pAcip.bin; 
		[ ! -r $file ] && echo $i - $j; 
	done
done | sort -un
