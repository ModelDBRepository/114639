function take_snapshot
	int n
	openfile {snapshotname} w
	openfile {allcompsfilename} r
	str thiscompt = {readfile {allcompsfilename}}
	str comptpath = {cellpath} @ "/" @ {thiscompt}
	if ({exists {cellpath}})
		if ({getfield {cellpath} chanmode} > 1)
			call {cellpath} HSAVE
		end
	end
//	echo {comptpath}
	save {comptpath} {snapshotname}
	save {comptpath}/Na_fast_GP {snapshotname} -append
	save {comptpath}/Na_slow_GP {snapshotname} -append
	save {comptpath}/Kv2_GP {snapshotname} -append
	save {comptpath}/Kv3_GP {snapshotname} -append
	save {comptpath}/Kv4_fast_GP {snapshotname} -append
	save {comptpath}/Kv4_slow_GP {snapshotname} -append
	save {comptpath}/KCNQ_GP {snapshotname} -append
	save {comptpath}/K_ahp_GP {snapshotname} -append
	save {comptpath}/Ca_HVA_GP {snapshotname} -append
	save {comptpath}/h_HCN_GP {snapshotname} -append
	save {comptpath}/h_HCN2_GP {snapshotname} -append
	save {comptpath}/Ca_GP_conc {snapshotname} -append
//	save {comptpath}/AMPA {snapshotname} -append
//	save {comptpath}/GABA {snapshotname} -append
	//save {comptpath}/Ca_GP_nernst {snapshotname} -append
	for (n = 2; n <= {ncomps}; n = n+1)
		thiscompt = {readfile {allcompsfilename}}
		comptpath = {cellpath} @ "/" @ {thiscompt}
//		echo {comptpath}
		save {comptpath} {snapshotname} -append
		save {comptpath}/Na_fast_GP {snapshotname} -append
		save {comptpath}/Na_slow_GP {snapshotname} -append
		save {comptpath}/Kv2_GP {snapshotname} -append
		save {comptpath}/Kv3_GP {snapshotname} -append
		save {comptpath}/Kv4_fast_GP {snapshotname} -append
		save {comptpath}/Kv4_slow_GP {snapshotname} -append
		save {comptpath}/KCNQ_GP {snapshotname} -append
		save {comptpath}/K_ahp_GP {snapshotname} -append
		save {comptpath}/Ca_HVA_GP {snapshotname} -append
		save {comptpath}/h_HCN_GP {snapshotname} -append
		save {comptpath}/h_HCN2_GP {snapshotname} -append
		save {comptpath}/Ca_GP_conc {snapshotname} -append
		//save {comptpath}/Ca_GP_nernst {snapshotname} -append
	end
	closefile {snapshotname}
	closefile {allcompsfilename}
end
	
function restore_from_snapshot
end
	
