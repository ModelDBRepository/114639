// genesis
//
// Cell morphology file for GENESIS.
// Written by cvapp (http://www.neuro.soton.ac.uk/cells/#software).
//
//	GP3 = cell BG0123C by Jesse Hanson.
//
//	Axon modeled according to Shen et al (1999), J Neurophysiol. 82: 3006-20.
// 	Dendritic diameter subdivisions added 09/30/2004 by J. Edgerton.
//	Each dendritic prototype now has 2 defining variables:
//		d = distance from soma, with segments as follows:
//			d0 = 0-25 microns from soma
//			d25 = >25 to 50 microns
//			d50 = >50 to 100 microns
//			all remaining divisions are 100 microns long, 
//				e.g. d100 means 100 < d <= 200 microns from soma.
//		dia = diameter rating:
//			dia0 = < 0.5 microns
//			dia1 = 0.5 to 1 micron
//			dia2 = > 1 micron
//			CaHVA density is scaled based on diameter rating according to
//				Hanson & Smith, 2002.
//			Once a dendrite crosses the line between two ratings, it cannot
//				go back to a higher rating again even if the diam thickens.
//			If a transition occurs for a short stretch but the majority of
//				the dendrite distal to that stretch is at the previous level, 
//				ignore the transition.
//			In cases where it is oscillating around a transition, make the
//				transition occur where the compartment and 3 of the next 4
//				are at the new level.

*absolute
*asymmetric
*cartesian

// End of cvapp-generated header file.

*lambda_warn .001 .01 --> check electrotonic lengths

*origin 0       0       0
*set_global RA       	{RA}
*set_global EREST_ACT   {EREST_ACT}

*set_compt_param RM	{RM_sd}
*set_compt_param CM	{CM}
*set_compt_param ELEAK	{ELEAK_sd}


*compt	/library/GP_soma
soma	none	0	0	0	8.6	

*compt /library/GP_axHill
axHill		soma		5	0	0	4.75

*set_compt_param RM       	{RM_ax}
*set_compt_param ELEAK		{ELEAK_ax}

*compt /library/GP_axIS
axIS[0]		axHill		7	0	0	1.5
axIS[1]		axIS[0]		9	0	0	1.5
axIS[2]		axIS[1]		11	0	0	1.5
axIS[3]		axIS[2]		13	0	0	1.5
axIS[4]		axIS[3]		15	0	0	1.5
axIS[5]		axIS[4]		17	0	0	1.5
axIS[6]		axIS[5]		19	0	0	1.5
axIS[7]		axIS[6]		21	0	0	1.5
axIS[8]		axIS[7]		23	0	0	1.5
axIS[9]		axIS[8]		25	0	0	1.5

*set_compt_param RM       	{RM_my}
*set_compt_param CM       	{CM_my}

*compt /library/GP_axIN
axIN[0]		axIS[9]		0	75	0	1.5
axIN[1]		axIN[0]		0	125	0	1.5
axIN[2]		axIN[1]		0	175	0	1.5
axIN[3]		axIN[2]		0	225	0	1.5
axIN[4]		axIN[3]		0	275	0	1.5
axIN[5]		axIN[4]		0	325	0	1.5
axIN[6]		axIN[5]		0	375	0	1.5
axIN[7]		axIN[6]		0	425	0	1.5
axIN[8]		axIN[7]		0	475	0	1.5
axIN[9]		axIN[8]		0	525	0	1.5
axIN[10]	axIN[9]		0	575	0	1.5
axIN[11]	axIN[10]	0	625	0	1.5
axIN[12]	axIN[11]	0	675	0	1.5
axIN[13]	axIN[12]	0	725	0	1.5
axIN[14]	axIN[13]	0	775	0	1.5
axIN[15]	axIN[14]	0	825	0	1.5
axIN[16]	axIN[15]	0	875	0	1.5
axIN[17]	axIN[16]	0	925	0	1.5
axIN[18]	axIN[17]	0	975	0	1.5
axIN[19]	axIN[18]	0	1025	0	1.5

*set_compt_param RM       	{RM_ax}
*set_compt_param CM       	{CM}
*set_compt_param ELEAK		{ELEAK_ax}

*compt /library/GP_axNode
axNode[0]	axIN[19]	0	1026	0	1

*set_compt_param RM       	{RM_my}
*set_compt_param CM       	{CM_my}

*compt /library/GP_axIN
axIN[20]	axNode[0]	0	1076	0	1.5
axIN[21]	axIN[20]	0	1126	0	1.5
axIN[22]	axIN[21]	0	1176	0	1.5
axIN[23]	axIN[22]	0	1226	0	1.5
axIN[24]	axIN[23]	0	1276	0	1.5
axIN[25]	axIN[24]	0	1326	0	1.5
axIN[26]	axIN[25]	0	1376	0	1.5
axIN[27]	axIN[26]	0	1426	0	1.5
axIN[28]	axIN[27]	0	1476	0	1.5
axIN[29]	axIN[28]	0	1526	0	1.5
axIN[30]	axIN[29]	0	1576	0	1.5
axIN[31]	axIN[30]	0	1626	0	1.5
axIN[32]	axIN[31]	0	1676	0	1.5
axIN[33]	axIN[32]	0	1726	0	1.5
axIN[34]	axIN[33]	0	1776	0	1.5
axIN[35]	axIN[34]	0	1826	0	1.5
axIN[36]	axIN[35]	0	1876	0	1.5
axIN[37]	axIN[36]	0	1926	0	1.5
axIN[38]	axIN[37]	0	1976	0	1.5
axIN[39]	axIN[38]	0	2026	0	1.5

*set_compt_param RM       	{RM_ax}
*set_compt_param CM       	{CM}

*compt /library/GP_axNode
axNode[1]	axIN[39]	0	2027	0	1

*set_compt_param RM       	{RM_my}
*set_compt_param CM       	{CM_my}

*compt /library/GP_axIN
axIN[40]	axNode[1]	0	2077	0	1.5
axIN[41]	axIN[40]	0	2127	0	1.5
axIN[42]	axIN[41]	0	2177	0	1.5
axIN[43]	axIN[42]	0	2227	0	1.5
axIN[44]	axIN[43]	0	2277	0	1.5
axIN[45]	axIN[44]	0	2327	0	1.5
axIN[46]	axIN[45]	0	2377	0	1.5
axIN[47]	axIN[46]	0	2427	0	1.5
axIN[48]	axIN[47]	0	2477	0	1.5
axIN[49]	axIN[48]	0	2527	0	1.5
axIN[50]	axIN[49]	0	2577	0	1.5
axIN[51]	axIN[50]	0	2627	0	1.5
axIN[52]	axIN[51]	0	2677	0	1.5
axIN[53]	axIN[52]	0	2727	0	1.5
axIN[54]	axIN[53]	0	2777	0	1.5
axIN[55]	axIN[54]	0	2827	0	1.5
axIN[56]	axIN[55]	0	2877	0	1.5
axIN[57]	axIN[56]	0	2927	0	1.5
axIN[58]	axIN[57]	0	2977	0	1.5
axIN[59]	axIN[58]	0	3027	0	1.5

*set_compt_param RM	{RM_sd}
*set_compt_param CM	{CM}
*set_compt_param ELEAK	{ELEAK_sd}

*compt /library/GP_dendrite_d0_dia2
p0[1]  soma  0.497  4.932  -2.04  1.246 

*compt /library/GP_dendrite_d0_dia1
p0[2]  p0[1]  0.81  10.087  -3.689  0.795 

*compt /library/GP_dendrite_d0_dia0
p0[3]  p0[2]  0.727  14.770  -3.86  0.489 
p0[4]  p0[3]  1.087  19.459  -3.918  0.471 

*compt /library/GP_dendrite_d25_dia0
p0[5]  p0[4]  1.916  24.098  -4.08  0.470 
p0[6]  p0[5]  2.455  28.78  -4.053  0.470 
p0[7]  p0[6]  3.122  33.282  -2.816  0.47 
p0[8]  p0[7]  4.032  37.578  -1.93  0.445 
p0[9]  p0[8]  5.046  41.459  -1.93  0.355 

*compt /library/GP_dendrite_d50_dia0
p0[10]  p0[9]  5.679  45.44  -1.93  0.353 
p0[11]  p0[10]  6.85  49.324  -1.781  0.351 
p0[12]  p0[11]  7.8  53.234  -1.166  0.350 
p0[13]  p0[12]  8.729  57.138  -0.619  0.352 
p0[14]  p0[13]  9.029  60.89  -2.169  0.350 
p0[15]  p0[14]  8.006  64.746  -2.38  0.357 
p0[16]  p0[15]  7.830  67.973  -0.408  0.376 
p0[17]  p0[16]  7.261  71.496  1.255  0.362 
p0[18]  p0[17]  6.28  75.33  2.49  0.35 
p0b1[0]  p0[18]  7.419  79.154  3.176  0.350 
p0b1[1]  p0b1[0]  8.243  83.007  4.069  0.351 
p0b1[2]  p0b1[1]  9.545  86.463  4.106  0.384 
p0b1[3]  p0b1[2]  10.690  89.212  5.480  0.432 

*compt /library/GP_dendrite_d100_dia0
p0b1[4]  p0b1[3]  12.658  90.19  8.881  0.350 
p0b1[5]  p0b1[4]  14.814  92.613  11.049  0.363 
p0b1[6]  p0b1[5]  17.025  95.153  13.126  0.358 
p0b1[7]  p0b1[6]  19.415  97.240  15.64  0.350 
p0b1[8]  p0b1[7]  21.335  100.075  17.729  0.353 
p0b1[9]  p0b1[8]  22.860  102.945  19.515  0.382 
p0b1[10]  p0b1[9]  25.54  105.908  20.123  0.351 
p0b1[11]  p0b1[10]  28.41  108.672  20.842  0.35 
p0b1[12]  p0b1[11]  29.621  110.930  23.942  0.352 
p0b1[13]  p0b1[12]  30.580  113.455  26.682  0.368 
p0b1[14]  p0b1[13]  30.580  116.812  28.944  0.350 
p0b1[15]  p0b1[14]  30.762  119.300  31.872  0.368 
p0b1[16]  p0b1[15]  31.063  121.144  35.463  0.350 
p0b1[17]  p0b1[16]  31.365  122.988  39.055  0.35 
p0b1[18]  p0b1[17]  29.751  126.474  39.428  0.367 
p0b1[19]  p0b1[18]  27.826  129.616  40.426  0.371 
p0b1[20]  p0b1[19]  26.063  132.166  43.029  0.35 
p0b1[21]  p0b1[20]  24.300  134.716  45.633  0.350 
p0b1[22]  p0b1[21]  23.879  136.887  48.935  0.357 
p0b1[23]  p0b1[22]  23.72  139.109  52.101  0.366 
p0b1[24]  p0b1[23]  23.72  142.38  54.660  0.35 
p0b1b1[0]  p0b1[24]  25.668  146.009  54.716  0.352 
p0b1b1[1]  p0b1b1[0]  28.716  148.047  56.649  0.35 
p0b1b1[2]  p0b1b1[1]  31.207  150.903  57.61  0.371 
p0b1b1[3]  p0b1b1[2]  33.264  154.324  58.024  0.361 

*compt /library/GP_dendrite_d200_dia0
p0b1b1[4]  p0b1b1[3]  35.834  156.678  60.267  0.35 
p0b1b1[5]  p0b1b1[4]  38.368  159.481  61.46  0.366 
p0b1b1[6]  p0b1b1[5]  40.773  162.845  61.46  0.351 
p0b1b1[7]  p0b1b1[6]  41.694  166.691  61.499  0.367 
p0b1b1[8]  p0b1b1[7]  40.323  170.574  61.673  0.352 
p0b1b1[9]  p0b1b1[8]  40.097  174.687  61.512  0.352 
p0b1b1[10]  p0b1b1[9]  39.410  177.74  64.3  0.35 

*compt /library/GP_dendrite_d100_dia0
p0b1b2[0]  p0b1[24]  22.213  146.098  54.739  0.35 
p0b1b2[1]  p0b1b2[0]  19.653  148.907  54.77  0.369 
p0b1b2[2]  p0b1b2[1]  17.712  152.276  54.77  0.361 
p0b1b2[3]  p0b1b2[2]  14.597  154.659  54.77  0.358 

*compt /library/GP_dendrite_d200_dia0
p0b1b2[4]  p0b1b2[3]  11.16  156.672  54.77  0.353 
p0b1b2[5]  p0b1b2[4]  7.645  158.55  54.77  0.352 
p0b1b2[6]  p0b1b2[5]  4.024  160.23  54.77  0.352 
p0b1b2[7]  p0b1b2[6]  1.121  162.720  55.197  0.365 
p0b1b2[8]  p0b1b2[7]  -0.718  164.772  58.113  0.350 
p0b1b2[9]  p0b1b2[8]  -2.795  166.740  60.67  0.366 
p0b1b2[10]  p0b1b2[9]  -6.237  168.098  61.459  0.371 
p0b1b2[11]  p0b1b2[10]  -8.539  170.032  63.855  0.365 
p0b1b2[12]  p0b1b2[11]  -10.861  170.979  66.641  0.375 
p0b1b2[13]  p0b1b2[12]  -13.739  171.795  69.174  0.358 
p0b1b2[14]  p0b1b2[13]  -16.75  173.94  70.42  0.35 
p0b1b2b1[0]  p0b1b2[14]  -17.740  177.506  70.42  0.35 
p0b1b2b1[1]  p0b1b2b1[0]  -17.266  180.850  71.322  0.371 
p0b1b2b1[2]  p0b1b2b1[1]  -16.664  182.795  73.960  0.389 
p0b1b2b1[3]  p0b1b2b1[2]  -16.328  183.764  77.516  0.350 
p0b1b2b1[4]  p0b1b2b1[3]  -15.992  184.734  81.072  0.35 
p0b1b2b1[5]  p0b1b2b1[4]  -15.477  186.997  82.707  0.456 
p0b1b2b1[6]  p0b1b2b1[5]  -14.77  190.640  82.33  0.35 
p0b1b2b2[0]  p0b1b2[14]  -20.527  173.263  70.31  0.350 
p0b1b2b2[1]  p0b1b2b2[0]  -24.281  174.089  70.31  0.350 
p0b1b2b2[2]  p0b1b2b2[1]  -26.91  174.314  72.933  0.362 
p0b1b2b2[3]  p0b1b2b2[2]  -29.984  174.546  74.873  0.369 
p0b1b2b2[4]  p0b1b2b2[3]  -33.714  174.884  75.736  0.350 
p0b1b2b2[5]  p0b1b2b2[4]  -36.476  177.141  75.98  0.376 
p0b1b2b2[6]  p0b1b2b2[5]  -39.222  179.727  76.491  0.353 
p0b1b2b2[7]  p0b1b2b2[6]  -42.238  181.31  77.91  0.365 
p0b1b2b2[8]  p0b1b2b2[7]  -46.05  181.54  78.59  0.35 

*compt /library/GP_dendrite_d50_dia0
p0b2[0]  p0[18]  4.741  76.407  6.195  0.350 
p0b2[1]  p0b2[0]  3.201  77.484  9.9  0.350 
p0b2[2]  p0b2[1]  1.092  79.152  12.755  0.371 
p0b2[3]  p0b2[2]  -1.779  81.613  14.474  0.350 

*compt /library/GP_dendrite_d100_dia0
p0b2[4]  p0b2[3]  -5.251  83.492  15.481  0.357 
p0b2[5]  p0b2[4]  -9.026  85.124  15.99  0.351 
p0b2[6]  p0b2[5]  -12.694  87.073  15.99  0.350 
p0b2[7]  p0b2[6]  -16.446  87.161  14.453  0.358 
p0b2[8]  p0b2[7]  -20.162  87.028  12.868  0.36 
p0b2[9]  p0b2[8]  -24.03  87.146  11.359  0.350 
p0b2[10]  p0b2[9]  -27.803  88.063  10.660  0.368 
p0b2[11]  p0b2[10]  -31.669  89.582  10.660  0.350 
p0b2[12]  p0b2[11]  -35.516  91.149  10.660  0.350 
p0b2[13]  p0b2[12]  -38.143  91.460  7.901  0.380 
p0b2[14]  p0b2[13]  -41.243  91.788  5.784  0.386 
p0b2[15]  p0b2[14]  -45.23  92.61  5.264  0.354 
p0b2[16]  p0b2[15]  -49.053  93.709  5.44  0.365 
p0b2[17]  p0b2[16]  -53.153  93.585  5.081  0.353 
p0b2[18]  p0b2[17]  -57.284  93.271  4.88  0.351 
p0b2[19]  p0b2[18]  -61.286  92.607  4.421  0.356 
p0b2[20]  p0b2[19]  -65.225  91.976  3.740  0.359 
p0b2[21]  p0b2[20]  -69.346  91.676  3.740  0.352 
p0b2[22]  p0b2[21]  -72.509  92.274  1.364  0.363 
p0b2[23]  p0b2[22]  -75.202  93.635  0.163  0.448 
p0b2[24]  p0b2[23]  -77.089  96.356  2.67  0.35 
p0b2[25]  p0b2[24]  -78.76  97.407  -0.627  0.378 
p0b2[26]  p0b2[25]  -80.460  98.37  -4.42  0.35 

*compt /library/GP_dendrite_d0_dia2
p1[1]  soma  -0.761  -4.720  0.827  1.061 

*compt /library/GP_dendrite_d0_dia1
p1[2]  p1[1]  -1.713  -5.300  5.186  0.58 
p1[3]  p1[2]  -3.948  -6.535  6.910  0.575 

*compt /library/GP_dendrite_d0_dia0
p1[4]  p1[3]  -6.28  -9.100  6.910  0.35 
p1b1[0]  p1[4]  -5.429  -12.278  9.407  0.350 

*compt /library/GP_dendrite_d25_dia0
p1b1[1]  p1b1[0]  -4.592  -15.655  11.34  0.363 
p1b1[2]  p1b1[1]  -3.552  -19.647  11.34  0.350 
p1b1[3]  p1b1[2]  -3.388  -23.182  13.106  0.366 
p1b1[4]  p1b1[3]  -3.434  -26.569  15.465  0.350 
p1b1[5]  p1b1[4]  -3.445  -30.259  17.187  0.355 
p1b1[6]  p1b1[5]  -3.851  -34.095  18.637  0.351 

*compt /library/GP_dendrite_d50_dia0
p1b1[7]  p1b1[6]  -3.95  -38.157  18.799  0.355 
p1b1[8]  p1b1[7]  -3.858  -42.104  19.504  0.360 
p1b1[9]  p1b1[8]  -3.655  -45.832  21.272  0.35 
p1b1[10]  p1b1[9]  -2.316  -49.464  22.498  0.356 
p1b1[11]  p1b1[10]  -0.498  -53.092  23.02  0.353 
p1b1[12]  p1b1[11]  1.113  -56.787  23.569  0.355 
p1b1[13]  p1b1[12]  2.344  -60.521  24.835  0.35 
p1b1[14]  p1b1[13]  2.724  -64.192  26.594  0.354 
p1b1[15]  p1b1[14]  2.865  -67.877  28.35  0.354 
p1b1[16]  p1b1[15]  3.669  -71.928  28.35  0.35 
p1b1[17]  p1b1[16]  4.789  -75.874  28.403  0.352 
p1b1[18]  p1b1[17]  5.58  -79.37  30.61  0.35 

*compt /library/GP_dendrite_d100_dia0
p1b1b1[0]  p1b1[18]  8.820  -81.974  30.61  0.350 
p1b1b1[1]  p1b1b1[0]  10.643  -85.453  30.61  0.370 
p1b1b1[2]  p1b1b1[1]  12.679  -89.062  30.61  0.351 
p1b1b1[3]  p1b1b1[2]  14.944  -92.54  30.61  0.351 
p1b1b1[4]  p1b1b1[3]  16.391  -96.424  30.612  0.350 
p1b1b1[5]  p1b1b1[4]  16.689  -99.739  31.136  0.230 
p1b1b1[6]  p1b1b1[5]  17.059  -103.037  31.63  0.231 
p1b1b1[7]  p1b1b1[6]  18.488  -106.084  31.63  0.230 
p1b1b1[8]  p1b1b1[7]  19.619  -109.256  31.63  0.230 
p1b1b1[9]  p1b1b1[8]  21.096  -112.283  31.646  0.230 
p1b1b1[10]  p1b1b1[9]  22.258  -115.440  31.75  0.230 
p1b1b1[11]  p1b1b1[10]  22.889  -118.624  32.105  0.237 
p1b1b1[12]  p1b1b1[11]  23.474  -121.193  34.206  0.230 
p1b1b1[13]  p1b1b1[12]  24.06  -123.762  36.308  0.230 
p1b1b1[14]  p1b1b1[13]  24.948  -126.778  36.118  0.246 
p1b1b1[15]  p1b1b1[14]  25.915  -129.909  35.335  0.230 
p1b1b1[16]  p1b1b1[15]  26.695  -133.148  35.04  0.232 
p1b1b1[17]  p1b1b1[16]  27.77  -136.333  35.04  0.231 
p1b1b1[18]  p1b1b1[17]  28.968  -139.455  35.231  0.231 
p1b1b1[19]  p1b1b1[18]  30.118  -142.497  36.117  0.23 
p1b1b1[20]  p1b1b1[19]  31.267  -145.538  37.003  0.230 
p1b1b1[21]  p1b1b1[20]  31.844  -148.818  37.19  0.232 
p1b1b1[22]  p1b1b1[21]  32.445  -152.099  37.19  0.232 
p1b1b1[23]  p1b1b1[22]  34.224  -154.961  37.19  0.230 
p1b1b1[24]  p1b1b1[23]  35.808  -157.921  37.19  0.231 
p1b1b1[25]  p1b1b1[24]  37.261  -160.959  37.19  0.230 
p1b1b1[26]  p1b1b1[25]  38.836  -163.938  37.19  0.23 
p1b1b1[27]  p1b1b1[26]  40.137  -166.933  37.952  0.231 
p1b1b1[28]  p1b1b1[27]  41.390  -169.931  38.846  0.23 

*compt /library/GP_dendrite_d200_dia0
p1b1b1[29]  p1b1b1[28]  42.620  -173.045  39.01  0.231 
p1b1b1[30]  p1b1b1[29]  43.8  -176.201  39.01  0.230 
p1b1b1[31]  p1b1b1[30]  44.772  -179.426  39.01  0.230 
p1b1b1[32]  p1b1b1[31]  44.977  -182.69  39.736  0.231 
p1b1b1[33]  p1b1b1[32]  44.858  -186.033  39.910  0.231 
p1b1b1[34]  p1b1b1[33]  44.147  -189.280  39.910  0.233 
p1b1b1[35]  p1b1b1[34]  43.687  -191.455  37.938  0.261 
p1b1b1[36]  p1b1b1[35]  43.744  -194.38  36.443  0.236 
p1b1b1[37]  p1b1b1[36]  43.828  -197.574  36.06  0.241 
p1b1b1[38]  p1b1b1[37]  43.499  -200.928  36.06  0.23 
p1b1b1[39]  p1b1b1[38]  43.69  -204.231  35.449  0.230 
p1b1b1[40]  p1b1b1[39]  43.502  -207.513  35.04  0.234 
p1b1b1[41]  p1b1b1[40]  42.614  -210.764  35.04  0.23 
p1b1b1[42]  p1b1b1[41]  41.735  -214.012  35.04  0.230 
p1b1b1[43]  p1b1b1[42]  41.219  -217.326  35.04  0.231 
p1b1b1[44]  p1b1b1[43]  40.483  -220.580  35.04  0.232 
p1b1b1[45]  p1b1b1[44]  39.879  -223.392  36.292  0.247 
p1b1b1[46]  p1b1b1[45]  39.665  -225.916  38.515  0.23 
p1b1b1[47]  p1b1b1[46]  39.375  -228.745  39.910  0.245 
p1b1b1[48]  p1b1b1[47]  39.005  -232.094  39.910  0.230 
p1b1b1[49]  p1b1b1[48]  38.708  -235.366  40.267  0.235 
p1b1b1[50]  p1b1b1[49]  38.108  -238.353  41.61  0.233 
p1b1b1[51]  p1b1b1[50]  37.09  -241.457  41.61  0.237 
p1b1b1[52]  p1b1b1[51]  36.859  -244.769  41.977  0.232 
p1b1b1[53]  p1b1b1[52]  36.390  -248.022  42.723  0.23 
p1b1b1[54]  p1b1b1[53]  35.662  -251.260  43.09  0.232 
p1b1b1[55]  p1b1b1[54]  34.779  -254.495  43.09  0.231 
p1b1b1[56]  p1b1b1[55]  35.193  -257.84  43.09  0.230 
p1b1b1[57]  p1b1b1[56]  35.306  -260.316  45.100  0.243 
p1b1b1[58]  p1b1b1[57]  34.275  -262.815  46.339  0.261 

*compt /library/GP_dendrite_d300_dia0
p1b1b1[59]  p1b1b1[58]  33.096  -265.716  47.338  0.236 
p1b1b1[60]  p1b1b1[59]  32.237  -268.722  48.53  0.232 
p1b1b1[61]  p1b1b1[60]  31.394  -271.984  48.53  0.230 
p1b1b1[62]  p1b1b1[61]  30.559  -275.246  48.53  0.230 
p1b1b1[63]  p1b1b1[62]  29.695  -278.501  48.53  0.230 
p1b1b1[64]  p1b1b1[63]  29.217  -281.81  48.53  0.232 
p1b1b1[65]  p1b1b1[64]  28.387  -285.048  48.53  0.232 
p1b1b1[66]  p1b1b1[65]  27.127  -288.174  48.53  0.23 
p1b1b1[67]  p1b1b1[66]  25.867  -291.3  48.53  0.230 
p1b1b1[68]  p1b1b1[67]  24.607  -294.425  48.53  0.23 
p1b1b1[69]  p1b1b1[68]  23.441  -297.587  48.53  0.230 
p1b1b1[70]  p1b1b1[69]  21.968  -300.524  48.53  0.236 
p1b1b1[71]  p1b1b1[70]  20.207  -303.397  48.53  0.230 
p1b1b1[72]  p1b1b1[71]  18.413  -306.250  48.53  0.230 
p1b1b1[73]  p1b1b1[72]  16.595  -309.087  48.53  0.23 
p1b1b1[74]  p1b1b1[73]  14.838  -311.955  48.53  0.230 
p1b1b1[75]  p1b1b1[74]  13.251  -314.928  48.53  0.230 
p1b1b1[76]  p1b1b1[75]  12.242  -318.129  48.53  0.231 
p1b1b1[77]  p1b1b1[76]  11.168  -321.308  48.53  0.231 
p1b1b1[78]  p1b1b1[77]  9.907  -324.433  48.53  0.23 
p1b1b1[79]  p1b1b1[78]  10.073  -327.72  48.53  0.236 
p1b1b1[80]  p1b1b1[79]  10.582  -331.051  48.53  0.230 
p1b1b1[81]  p1b1b1[80]  11.031  -334.391  48.53  0.23 
p1b1b1[82]  p1b1b1[81]  11.383  -337.74  48.53  0.230 
p1b1b1[83]  p1b1b1[82]  11.516  -340.974  48.299  0.239 
p1b1b1[84]  p1b1b1[83]  11.575  -343.374  45.934  0.23 
p1b1b1[85]  p1b1b1[84]  11.607  -345.854  43.801  0.237 
p1b1b1[86]  p1b1b1[85]  11.335  -349.193  44.167  0.230 
p1b1b1[87]  p1b1b1[86]  11.063  -352.532  44.533  0.230 
p1b1b1[88]  p1b1b1[87]  10.790  -355.871  44.899  0.230 

*compt /library/GP_dendrite_d400_dia0
p1b1b1[89]  p1b1b1[88]  11.172  -358.864  46.157  0.237 
p1b1b1[90]  p1b1b1[89]  11.879  -361.685  47.86  0.230 
p1b1b1[91]  p1b1b1[90]  11.620  -364.825  48.967  0.232 
p1b1b1[92]  p1b1b1[91]  11.286  -367.949  50.164  0.231 
p1b1b1[93]  p1b1b1[92]  11.044  -370.989  51.599  0.230 
p1b1b1[94]  p1b1b1[93]  10.801  -374.028  53.034  0.23 
p1b1b1[95]  p1b1b1[94]  9.523  -376.813  54.055  0.240 
p1b1b1[96]  p1b1b1[95]  7.510  -379.416  54.781  0.23 
p1b1b1[97]  p1b1b1[96]  5.497  -382.02  55.507  0.23 
p1b1b1[98]  p1b1b1[97]  4.260  -385.137  55.56  0.231 
p1b1b1[99]  p1b1b1[98]  2.949  -388.217  55.591  0.232 
p1b1b1[100]  p1b1b1[99]  0.819  -390.819  55.808  0.230 
p1b1b1[101]  p1b1b1[100]  -1.312  -393.421  56.025  0.23 
p1b1b1[102]  p1b1b1[101]  -3.443  -396.022  56.243  0.23 
p1b1b1[103]  p1b1b1[102]  -5.574  -398.624  56.460  0.23 
p1b1b1[104]  p1b1b1[103]  -7.968  -400.951  56.637  0.232 
p1b1b1[105]  p1b1b1[104]  -10.686  -402.939  56.766  0.23 
p1b1b1[106]  p1b1b1[105]  -13.729  -404.269  56.81  0.233 
p1b1b1[107]  p1b1b1[106]  -16.977  -405.17  56.81  0.23 
p1b1b1[108]  p1b1b1[107]  -20.58  -406.17  56.81  0.23 
p1b1b1b1[0]  p1b1b1[108]  -21.353  -407.314  54.172  0.23 
p1b1b1b1[1]  p1b1b1b1[0]  -22.127  -408.457  51.533  0.230 
p1b1b1b1[2]  p1b1b1b1[1]  -23.189  -411.050  51.179  0.242 
p1b1b1b1[3]  p1b1b1b1[2]  -23.374  -413.583  50.236  0.253 
p1b1b1b1[4]  p1b1b1b1[3]  -22.702  -415.895  48.484  0.23 
p1b1b1b1[5]  p1b1b1b1[4]  -22.030  -418.207  46.731  0.230 
p1b1b1b1[6]  p1b1b1b1[5]  -20.086  -418.820  44.649  0.235 
p1b1b1b1[7]  p1b1b1b1[6]  -18.02  -419.3  42.52  0.23 
p1b1b1b2[0]  p1b1b1[108]  -23.872  -406.254  56.726  0.230 
p1b1b1b2[1]  p1b1b1b2[0]  -25.96  -404.270  56.7  0.263 
p1b1b1b2[2]  p1b1b1b2[1]  -27.44  -401.328  56.7  0.23 
p1b1b1b2[3]  p1b1b1b2[2]  -28.480  -398.215  56.7  0.231 
p1b1b1b2[4]  p1b1b1b2[3]  -29.285  -395.043  56.7  0.232 
p1b1b1b2[5]  p1b1b1b2[4]  -31.037  -392.256  56.7  0.230 
p1b1b1b2[6]  p1b1b1b2[5]  -31.86  -389.201  56.7  0.239 
p1b1b1b2[7]  p1b1b1b2[6]  -32.678  -386.068  56.729  0.234 
p1b1b1b2[8]  p1b1b1b2[7]  -33.919  -383.017  56.772  0.230 
p1b1b1b2[9]  p1b1b1b2[8]  -35.255  -380.024  56.819  0.231 

*compt /library/GP_dendrite_d500_dia0
p1b1b1b2[10]  p1b1b1b2[9]  -36.941  -377.197  56.934  0.230 
p1b1b1b2[11]  p1b1b1b2[10]  -38.654  -374.388  57.04  0.230 
p1b1b1b2[12]  p1b1b1b2[11]  -40.673  -371.786  57.04  0.230 
p1b1b1b2[13]  p1b1b1b2[12]  -42.735  -369.218  57.04  0.230 
p1b1b1b2[14]  p1b1b1b2[13]  -44.875  -366.718  57.04  0.230 
p1b1b1b2[15]  p1b1b1b2[14]  -47.145  -364.332  57.04  0.23 
p1b1b1b2[16]  p1b1b1b2[15]  -48.833  -362.527  58.832  0.248 
p1b1b1b2[17]  p1b1b1b2[16]  -50.358  -361.008  61.238  0.235 
p1b1b1b2[18]  p1b1b1b2[17]  -52.715  -360.494  63.481  0.230 
p1b1b1b2[19]  p1b1b1b2[18]  -55.120  -359.97  65.77  0.23 
p1b1b1b2b1[0]  p1b1b1b2[19]  -56.693  -358.739  63.301  0.23 
p1b1b1b2b1[1]  p1b1b1b2b1[0]  -58.267  -357.508  60.832  0.230 
p1b1b1b2b1[2]  p1b1b1b2b1[1]  -59.74  -355.940  58.860  0.250 
p1b1b1b2b1[3]  p1b1b1b2b1[2]  -61.059  -353.052  58.926  0.23 
p1b1b1b2b1[4]  p1b1b1b2b1[3]  -62.600  -350.459  59.131  0.242 
p1b1b1b2b1[5]  p1b1b1b2b1[4]  -64.530  -347.99  59.760  0.23 
p1b1b1b2b2[0]  p1b1b1b2[19]  -57.078  -360.377  63.781  0.23 
p1b1b1b2b2[1]  p1b1b1b2b2[0]  -59.035  -360.784  61.792  0.23 
p1b1b1b2b2[2]  p1b1b1b2b2[1]  -60.998  -361.29  60.352  0.261 
p1b1b1b2b2[3]  p1b1b1b2b2[2]  -62.993  -362.357  62.036  0.23 
p1b1b1b2b2[4]  p1b1b1b2b2[3]  -65  -363.43  63.730  0.23 
p1b1b1b2b2b1[0]  p1b1b1b2b2[4]  -68.342  -363.917  63.730  0.230 
p1b1b1b2b2b1[1]  p1b1b1b2b2b1[0]  -71.684  -364.405  63.730  0.23 
p1b1b1b2b2b1[2]  p1b1b1b2b2b1[1]  -75.025  -364.892  63.730  0.230 
p1b1b1b2b2b1[3]  p1b1b1b2b2b1[2]  -78.353  -364.706  63.483  0.232 
p1b1b1b2b2b1[4]  p1b1b1b2b2b1[3]  -81.671  -364.201  63.110  0.230 
p1b1b1b2b2b1[5]  p1b1b1b2b2b1[4]  -84.99  -363.697  62.737  0.23 
p1b1b1b2b2b1[6]  p1b1b1b2b2b1[5]  -87.456  -361.456  62.710  0.233 
p1b1b1b2b2b1[7]  p1b1b1b2b2b1[6]  -89.619  -358.942  62.710  0.234 
p1b1b1b2b2b1[8]  p1b1b1b2b2b1[7]  -91.958  -356.506  62.710  0.23 
p1b1b1b2b2b1[9]  p1b1b1b2b2b1[8]  -94.339  -354.155  62.710  0.232 
p1b1b1b2b2b1[10]  p1b1b1b2b2b1[9]  -97.32  -352.49  62.710  0.23 
p1b1b1b2b2b2[0]  p1b1b1b2b2[4]  -66.286  -366.237  63.811  0.230 
p1b1b1b2b2b2[1]  p1b1b1b2b2b2[0]  -67.475  -369.086  63.84  0.230 
p1b1b1b2b2b2[2]  p1b1b1b2b2b2[1]  -68.025  -372.115  63.66  0.230 
p1b1b1b2b2b2[3]  p1b1b1b2b2b2[2]  -68.526  -375.157  63.465  0.230 
p1b1b1b2b2b2[4]  p1b1b1b2b2b2[3]  -68.741  -377.871  64.497  0.244 
p1b1b1b2b2b2[5]  p1b1b1b2b2b2[4]  -68.774  -380.379  66.299  0.230 
p1b1b1b2b2b2[6]  p1b1b1b2b2b2[5]  -68.808  -382.887  68.102  0.230 
p1b1b1b2b2b2[7]  p1b1b1b2b2b2[6]  -68.84  -385.2  69.85  0.23 

*compt /library/GP_dendrite_d100_dia0
p1b1b2[0]  p1b1[18]  3.898  -81.939  29.197  0.23 
p1b1b2[1]  p1b1b2[0]  2.383  -84.482  29.333  0.262 
p1b1b2[2]  p1b1b2[1]  1.085  -87.172  30.688  0.237 
p1b1b2[3]  p1b1b2[2]  -0.003  -90.206  31.671  0.231 
p1b1b2[4]  p1b1b2[3]  -0.993  -93.38  32.2  0.231 
p1b1b2[5]  p1b1b2[4]  -2.643  -96.330  32.2  0.23 
p1b1b2[6]  p1b1b2[5]  -3.525  -99.166  33.48  0.240 
p1b1b2[7]  p1b1b2[6]  -4.075  -101.953  35.312  0.23 
p1b1b2[8]  p1b1b2[7]  -4.854  -104.685  37.134  0.230 
p1b1b2[9]  p1b1b2[8]  -5.788  -107.379  38.949  0.23 
p1b1b2[10]  p1b1b2[9]  -6.738  -110.444  39.965  0.231 
p1b1b2[11]  p1b1b2[10]  -7.651  -113.555  40.82  0.232 
p1b1b2[12]  p1b1b2[11]  -8.197  -116.891  40.82  0.230 
p1b1b2[13]  p1b1b2[12]  -8.836  -120.042  41.354  0.238 
p1b1b2[14]  p1b1b2[13]  -9.370  -123.276  42.180  0.23 
p1b1b2[15]  p1b1b2[14]  -9.905  -126.510  43.006  0.230 
p1b1b2[16]  p1b1b2[15]  -10.439  -129.744  43.833  0.23 
p1b1b2[17]  p1b1b2[16]  -11.324  -132.955  44.398  0.230 
p1b1b2[18]  p1b1b2[17]  -12.231  -136.165  44.948  0.23 
p1b1b2[19]  p1b1b2[18]  -13.196  -139.363  45.442  0.230 
p1b1b2[20]  p1b1b2[19]  -14.338  -142.528  45.768  0.230 
p1b1b2[21]  p1b1b2[20]  -15.479  -145.693  46.095  0.230 
p1b1b2[22]  p1b1b2[21]  -16.621  -148.858  46.422  0.230 
p1b1b2[23]  p1b1b2[22]  -17.804  -151.915  47.209  0.231 
p1b1b2[24]  p1b1b2[23]  -18.985  -154.954  48.086  0.230 
p1b1b2[25]  p1b1b2[24]  -19.850  -158.218  48.235  0.230 
p1b1b2[26]  p1b1b2[25]  -20.921  -161.156  48.626  0.247 
p1b1b2[27]  p1b1b2[26]  -22.229  -164.211  49.241  0.230 
p1b1b2[28]  p1b1b2[27]  -23.585  -167.145  50.123  0.232 
p1b1b2[29]  p1b1b2[28]  -25.052  -169.799  51.618  0.23 

*compt /library/GP_dendrite_d200_dia0
p1b1b2[30]  p1b1b2[29]  -26.437  -172.447  53.193  0.230 
p1b1b2[31]  p1b1b2[30]  -27.735  -175.089  54.854  0.230 
p1b1b2[32]  p1b1b2[31]  -29.000  -178.118  55.22  0.235 
p1b1b2[33]  p1b1b2[32]  -30.120  -181.238  55.618  0.233 
p1b1b2[34]  p1b1b2[33]  -31.025  -184.329  56.644  0.23 
p1b1b2[35]  p1b1b2[34]  -31.93  -187.42  57.67  0.23 
p1b1b2[36]  p1b1b2[35]  -32.743  -190.548  58.622  0.231 
p1b1b2[37]  p1b1b2[36]  -33.148  -193.847  59.239  0.230 
p1b1b2[38]  p1b1b2[37]  -33.616  -197.143  59.760  0.231 
p1b1b2[39]  p1b1b2[38]  -34.419  -200.427  59.760  0.23 
p1b1b2[40]  p1b1b2[39]  -34.53  -203.270  61.374  0.238 
p1b1b2[41]  p1b1b2[40]  -34.573  -206.296  62.710  0.235 
p1b1b2[42]  p1b1b2[41]  -34.668  -209.648  62.710  0.232 
p1b1b2[43]  p1b1b2[42]  -34.324  -212.504  63.671  0.256 
p1b1b2[44]  p1b1b2[43]  -35.106  -215.107  65.681  0.23 
p1b1b2[45]  p1b1b2[44]  -35.960  -218.228  66.47  0.233 
p1b1b2[46]  p1b1b2[45]  -36.845  -221.404  67.165  0.231 
p1b1b2[47]  p1b1b2[46]  -37.784  -224.439  68.321  0.230 
p1b1b2[48]  p1b1b2[47]  -38.723  -227.473  69.476  0.230 
p1b1b2[49]  p1b1b2[48]  -40.609  -230.224  69.62  0.233 
p1b1b2[50]  p1b1b2[49]  -42.629  -232.934  69.62  0.23 
p1b1b2[51]  p1b1b2[50]  -45.328  -234.891  69.62  0.233 
p1b1b2[52]  p1b1b2[51]  -48.195  -236.683  69.62  0.23 
p1b1b2[53]  p1b1b2[52]  -51.061  -238.474  69.62  0.230 
p1b1b2[54]  p1b1b2[53]  -54.254  -239.546  69.62  0.231 
p1b1b2[55]  p1b1b2[54]  -57.49  -240.524  69.62  0.23 
p1b1b2[56]  p1b1b2[55]  -60.774  -241.312  69.62  0.230 
p1b1b2[57]  p1b1b2[56]  -64.084  -242  69.62  0.230 
p1b1b2[58]  p1b1b2[57]  -67.431  -242.444  69.62  0.230 
p1b1b2[59]  p1b1b2[58]  -70.790  -242.824  69.62  0.230 

*compt /library/GP_dendrite_d300_dia0
p1b1b2[60]  p1b1b2[59]  -73.974  -243.506  69.62  0.239 
p1b1b2[61]  p1b1b2[60]  -77.059  -244.755  69.62  0.234 
p1b1b2[62]  p1b1b2[61]  -80.425  -245.072  69.62  0.23 
p1b1b2[63]  p1b1b2[62]  -83.107  -246.078  71.175  0.238 
p1b1b2[64]  p1b1b2[63]  -85.7  -247.214  73.006  0.231 
p1b1b2[65]  p1b1b2[64]  -88.528  -248.680  74.137  0.230 
p1b1b2[66]  p1b1b2[65]  -91.356  -250.146  75.268  0.230 
p1b1b2[67]  p1b1b2[66]  -94.145  -251.695  76.181  0.234 
p1b1b2[68]  p1b1b2[67]  -97.101  -253.087  77.046  0.230 
p1b1b2[69]  p1b1b2[68]  -99.631  -255.297  76.99  0.231 
p1b1b2[70]  p1b1b2[69]  -102.127  -257.573  76.86  0.230 
p1b1b2[71]  p1b1b2[70]  -104.623  -259.849  76.73  0.23 
p1b1b2[72]  p1b1b2[71]  -106.876  -262.334  76.65  0.232 
p1b1b2[73]  p1b1b2[72]  -108.740  -265.154  76.65  0.23 
p1b1b2[74]  p1b1b2[73]  -108.878  -268.507  76.65  0.232 
p1b1b2[75]  p1b1b2[74]  -108.928  -271.887  76.65  0.23 
p1b1b2[76]  p1b1b2[75]  -109.635  -274.890  77.562  0.242 
p1b1b2[77]  p1b1b2[76]  -110.842  -277.607  79.170  0.230 
p1b1b2[78]  p1b1b2[77]  -111.852  -280.528  80.455  0.232 
p1b1b2[79]  p1b1b2[78]  -112.616  -283.7  81.338  0.230 
p1b1b2[80]  p1b1b2[79]  -113.414  -286.83  82.210  0.232 
p1b1b2[81]  p1b1b2[80]  -114.422  -289.926  82.928  0.233 
p1b1b2[82]  p1b1b2[81]  -115.81  -293.28  83.01  0.23 
p1b1b2b1[0]  p1b1b2[82]  -115.58  -295.58  82.78  0.23 
p1b1b2b1b1[0]  p1b1b2b1[0]  -118.490  -295.511  81.64  0.232 
p1b1b2b1b1[1]  p1b1b2b1b1[0]  -121.500  -296.18  81.64  0.236 
p1b1b2b1b1[2]  p1b1b2b1b1[1]  -123.770  -298.079  82.021  0.243 
p1b1b2b1b1[3]  p1b1b2b1b1[2]  -125.610  -300.036  83.680  0.23 
p1b1b2b1b1[4]  p1b1b2b1b1[3]  -127.412  -302.041  85.323  0.230 
p1b1b2b1b1[5]  p1b1b2b1b1[4]  -129.230  -304.021  86.879  0.234 

*compt /library/GP_dendrite_d400_dia0
p1b1b2b1b1[6]  p1b1b2b1b1[5]  -131.799  -305.581  87.847  0.23 
p1b1b2b1b1[7]  p1b1b2b1b1[6]  -134.41  -307.1  88.79  0.23 

*compt /library/GP_dendrite_d300_dia0
p1b1b2b1b2[0]  p1b1b2b1[0]  -115.817  -297.144  85.237  0.230 
p1b1b2b1b2[1]  p1b1b2b1b2[0]  -115.969  -299.143  87.284  0.235 
p1b1b2b1b2[2]  p1b1b2b1b2[1]  -116.04  -301.553  88.879  0.232 
p1b1b2b1b2[3]  p1b1b2b1b2[2]  -116.04  -304.403  88.231  0.230 
p1b1b2b1b2[4]  p1b1b2b1b2[3]  -115.706  -307.243  87.88  0.233 
p1b1b2b1b2[5]  p1b1b2b1b2[4]  -115  -310.051  87.815  0.232 
p1b1b2b1b2[6]  p1b1b2b1b2[5]  -114.18  -312.86  87.77  0.23 

*compt /library/GP_dendrite_d400_dia0
p1b1b2b1b2b1[0]  p1b1b2b1b2[6]  -112.843  -313.523  90.668  0.230 
p1b1b2b1b2b1[1]  p1b1b2b1b2b1[0]  -111.577  -314.283  93.094  0.264 
p1b1b2b1b2b1[2]  p1b1b2b1b2b1[1]  -111.072  -316.087  90.427  0.23 
p1b1b2b1b2b1[3]  p1b1b2b1b2b1[2]  -110.566  -317.891  87.760  0.23 
p1b1b2b1b2b1[4]  p1b1b2b1b2b1[3]  -110.46  -319.793  85.124  0.230 
p1b1b2b1b2b1[5]  p1b1b2b1b2b1[4]  -110.46  -321.721  82.496  0.230 
p1b1b2b1b2b1[6]  p1b1b2b1b2b1[5]  -110.197  -324.878  82.237  0.236 
p1b1b2b1b2b1[7]  p1b1b2b1b2b1[6]  -110.294  -328.122  82.089  0.231 
p1b1b2b1b2b1[8]  p1b1b2b1b2b1[7]  -110.94  -331.274  81.945  0.233 
p1b1b2b1b2b1[9]  p1b1b2b1b2b1[8]  -111.840  -334.109  81.424  0.248 
p1b1b2b1b2b1[10]  p1b1b2b1b2b1[9]  -111.15  -336.233  79.05  0.23 
p1b1b2b1b2b1[11]  p1b1b2b1b2b1[10]  -110.46  -338.357  76.676  0.23 
p1b1b2b1b2b1[12]  p1b1b2b1b2b1[11]  -109.76  -340.51  74.27  0.23 
p1b1b2b1b2b2[0]  p1b1b2b1b2[6]  -116.278  -315.157  88.329  0.23 
p1b1b2b1b2b2[1]  p1b1b2b1b2b2[0]  -117.668  -317.755  89.474  0.230 
p1b1b2b1b2b2[2]  p1b1b2b1b2b2[1]  -119.058  -320.352  90.619  0.230 
p1b1b2b1b2b2[3]  p1b1b2b1b2b2[2]  -120.359  -322.33  92.685  0.231 
p1b1b2b1b2b2[4]  p1b1b2b1b2b2[3]  -121.652  -324.248  94.84  0.230 
p1b1b2b1b2b2[5]  p1b1b2b1b2b2[4]  -122.482  -326.232  97.138  0.231 
p1b1b2b1b2b2[6]  p1b1b2b1b2b2[5]  -123.368  -328.755  98.2  0.253 
p1b1b2b1b2b2[7]  p1b1b2b1b2b2[6]  -124.585  -331.672  98.2  0.230 
p1b1b2b1b2b2[8]  p1b1b2b1b2b2[7]  -125.577  -334.646  98.035  0.232 
p1b1b2b1b2b2[9]  p1b1b2b1b2b2[8]  -126.16  -337.609  97.815  0.240 
p1b1b2b1b2b2[10]  p1b1b2b1b2b2[9]  -126.16  -339.105  100.6  0.230 
p1b1b2b1b2b2[11]  p1b1b2b1b2b2[10]  -126.16  -340.62  103.42  0.23 

*compt /library/GP_dendrite_d300_dia0
p1b1b2b2[0]  p1b1b2[82]  -116.799  -294.948  80.798  0.23 
p1b1b2b2[1]  p1b1b2b2[0]  -117.79  -296.62  78.58  0.23 
p1b1b2b2b1[0]  p1b1b2b2[1]  -117.627  -299.438  77.579  0.23 
p1b1b2b2b1[1]  p1b1b2b2b1[0]  -117.524  -302.338  77.3  0.236 
p1b1b2b2b1[2]  p1b1b2b2b1[1]  -117.474  -305.311  77.657  0.23 
p1b1b2b2b1[3]  p1b1b2b2b1[2]  -117.738  -308.156  78.290  0.235 
p1b1b2b2b1[4]  p1b1b2b2b1[3]  -118.617  -310.788  79.374  0.231 

*compt /library/GP_dendrite_d400_dia0
p1b1b2b2b1[5]  p1b1b2b2b1[4]  -119.3  -313.67  79.94  0.23 

*compt /library/GP_dendrite_d300_dia0
p1b1b2b2b2[0]  p1b1b2b2[1]  -120.810  -297.919  78.58  0.235 
p1b1b2b2b2[1]  p1b1b2b2b2[0]  -124.168  -298.040  78.58  0.230 
p1b1b2b2b2[2]  p1b1b2b2b2[1]  -127.482  -297.806  78.58  0.233 
p1b1b2b2b2[3]  p1b1b2b2b2[2]  -130.712  -296.878  78.58  0.230 
p1b1b2b2b2[4]  p1b1b2b2b2[3]  -133.932  -295.937  78.58  0.230 

*compt /library/GP_dendrite_d400_dia0
p1b1b2b2b2[5]  p1b1b2b2b2[4]  -137.093  -294.839  78.58  0.231 
p1b1b2b2b2[6]  p1b1b2b2b2[5]  -139.604  -293.74  77.211  0.252 
p1b1b2b2b2[7]  p1b1b2b2b2[6]  -141.815  -293.129  74.756  0.230 
p1b1b2b2b2[8]  p1b1b2b2b2[7]  -144.009  -292.495  72.292  0.230 
p1b1b2b2b2[9]  p1b1b2b2b2[8]  -146.163  -291.806  69.807  0.23 
p1b1b2b2b2[10]  p1b1b2b2b2[9]  -149.047  -291.872  68.244  0.236 
p1b1b2b2b2[11]  p1b1b2b2b2[10]  -152.127  -292.142  66.929  0.23 
p1b1b2b2b2[12]  p1b1b2b2b2[11]  -155.376  -292.355  66.607  0.236 
p1b1b2b2b2[13]  p1b1b2b2b2[12]  -158.722  -292.537  66.854  0.23 
p1b1b2b2b2[14]  p1b1b2b2b2[13]  -162.067  -292.718  67.101  0.23 
p1b1b2b2b2[15]  p1b1b2b2b2[14]  -165.317  -292.345  67.24  0.236 
p1b1b2b2b2[16]  p1b1b2b2b2[15]  -168.551  -291.432  67.24  0.23 
p1b1b2b2b2[17]  p1b1b2b2b2[16]  -171.738  -290.416  67.24  0.231 
p1b1b2b2b2[18]  p1b1b2b2b2[17]  -173.997  -287.989  67.24  0.233 
p1b1b2b2b2[19]  p1b1b2b2b2[18]  -176.16  -285.33  67.24  0.23 

*compt /library/GP_dendrite_d0_dia0
p1b2[0]  p1[4]  -8.394  -8.749  9.521  0.23 

*compt /library/GP_dendrite_d25_dia0
p1b2[1]  p1b2[0]  -10.942  -8.656  11.220  0.254 
p1b2[2]  p1b2[1]  -14.297  -9.047  11.220  0.23 
p1b2[3]  p1b2[2]  -17.008  -9.57  12.641  0.250 
p1b2[4]  p1b2[3]  -19.258  -10.189  15.084  0.230 
p1b2[5]  p1b2[4]  -22.134  -10.234  16.459  0.244 
p1b2[6]  p1b2[5]  -25.397  -10.053  17.313  0.230 
p1b2[7]  p1b2[6]  -28.595  -9.613  18.03  0.235 

*compt /library/GP_dendrite_d50_dia0
p1b2[8]  p1b2[7]  -31.559  -7.992  18.03  0.230 
p1b2[9]  p1b2[8]  -34.522  -6.371  18.03  0.23 
p1b2[10]  p1b2[9]  -37.319  -4.511  18.03  0.231 
p1b2[11]  p1b2[10]  -39.873  -2.3  18.03  0.23 
p1b2[12]  p1b2[11]  -42.464  -0.177  18.03  0.232 
p1b2[13]  p1b2[12]  -45.374  1.517  18.112  0.231 
p1b2[14]  p1b2[13]  -48.242  3.26  18.502  0.23 
p1b2[15]  p1b2[14]  -51.109  5.003  18.892  0.230 
p1b2[16]  p1b2[15]  -53.976  6.745  19.282  0.23 
p1b2[17]  p1b2[16]  -56.983  8.164  19.719  0.232 
p1b2[18]  p1b2[17]  -60.169  9.172  20.216  0.23 
p1b2[19]  p1b2[18]  -63.354  10.181  20.712  0.23 
p1b2[20]  p1b2[19]  -66.245  11.412  21.794  0.234 
p1b2[21]  p1b2[20]  -69.04  12.657  23.225  0.23 
p1b2[22]  p1b2[21]  -71.437  14.474  24.512  0.237 

*compt /library/GP_dendrite_d100_dia0
p1b2[23]  p1b2[22]  -73.990  16.08  26.033  0.23 
p1b2[24]  p1b2[23]  -76.493  18.312  26.35  0.231 
p1b2[25]  p1b2[24]  -79  20.557  26.642  0.230 
p1b2[26]  p1b2[25]  -81.603  21.273  28.634  0.232 
p1b2[27]  p1b2[26]  -84.209  21.946  30.675  0.230 
p1b2[28]  p1b2[27]  -86.051  23.601  32.742  0.241 
p1b2[29]  p1b2[28]  -86.129  26.672  34.147  0.230 
p1b2[30]  p1b2[29]  -85.843  29.885  34.897  0.235 
p1b2[31]  p1b2[30]  -86.089  32.355  36.327  0.271 
p1b2[32]  p1b2[31]  -86.63  35.546  37.08  0.234 
p1b2[33]  p1b2[32]  -87.27  38.359  38.589  0.239 
p1b2[34]  p1b2[33]  -87.576  41.680  38.958  0.232 
p1b2[35]  p1b2[34]  -87.687  44.81  40.225  0.230 
p1b2[36]  p1b2[35]  -87.713  47.890  41.552  0.232 
p1b2[37]  p1b2[36]  -86.744  50.406  43.587  0.230 
p1b2[38]  p1b2[37]  -86.019  53.111  45.446  0.231 
p1b2[39]  p1b2[38]  -85.552  56.007  47.085  0.231 
p1b2[40]  p1b2[39]  -85.23  58.870  48.805  0.232 
p1b2[41]  p1b2[40]  -84.619  62.101  48.948  0.236 
p1b2[42]  p1b2[41]  -83.918  64.875  50.742  0.23 
p1b2[43]  p1b2[42]  -82.717  67.865  51.25  0.238 
p1b2[44]  p1b2[43]  -81.339  70.948  51.25  0.23 
p1b2[45]  p1b2[44]  -80.81  72.46  54.31  0.23 
p1b2b1[0]  p1b2[45]  -78.385  74.513  54.31  0.23 
p1b2b1[1]  p1b2b1[0]  -75.960  76.566  54.31  0.230 
p1b2b1[2]  p1b2b1[1]  -73.703  78.286  54.190  0.199 
p1b2b1[3]  p1b2b1[2]  -71.739  79.427  53.861  0.120 
p1b2b1[4]  p1b2b1[3]  -69.775  80.567  53.532  0.120 
p1b2b1[5]  p1b2b1[4]  -67.811  81.708  53.204  0.12 
p1b2b1[6]  p1b2b1[5]  -66.306  80.864  54.171  0.139 
p1b2b1[7]  p1b2b1[6]  -64.613  79.807  55.303  0.12 
p1b2b1[8]  p1b2b1[7]  -63.341  78.360  55.408  0.143 
p1b2b1[9]  p1b2b1[8]  -62.541  76.478  54.366  0.120 

*compt /library/GP_dendrite_d200_dia0
p1b2b1[10]  p1b2b1[9]  -61.741  74.596  53.325  0.12 
p1b2b1[11]  p1b2b1[10]  -60.93  72.69  52.27  0.12 

*compt /library/GP_dendrite_d100_dia0
p1b2b2[0]  p1b2[45]  -81.241  75.584  54.2  0.239 
p1b2b2[1]  p1b2b2[0]  -80.84  78.823  54.2  0.231 
p1b2b2[2]  p1b2b2[1]  -80.057  81.163  55.798  0.256 
p1b2b2[3]  p1b2b2[2]  -79.026  83.092  58.219  0.231 
p1b2b2[4]  p1b2b2[3]  -77.969  85.129  60.494  0.233 
p1b2b2[5]  p1b2b2[4]  -78.890  86.971  63.039  0.23 
p1b2b2[6]  p1b2b2[5]  -79.315  88.04  66.026  0.235 
p1b2b2[7]  p1b2b2[6]  -79.512  88.754  69.216  0.23 

*compt /library/GP_dendrite_d200_dia0
p1b2b2[8]  p1b2b2[7]  -79.227  88.983  72.462  0.231 
p1b2b2[9]  p1b2b2[8]  -78.893  89.163  75.714  0.230 
p1b2b2[10]  p1b2b2[9]  -78.559  89.343  78.966  0.23 
p1b2b2[11]  p1b2b2[10]  -78.25  89.51  81.74  0.269 
p1b2b2[12]  p1b2b2[11]  -76.491  88.336  79.273  0.232 
p1b2b2[13]  p1b2b2[12]  -74.677  87.124  76.831  0.23 
p1b2b2[14]  p1b2b2[13]  -72.862  85.913  74.39  0.23 
p1b2b2[15]  p1b2b2[14]  -70.973  84.806  73.174  0.301 
p1b2b2[16]  p1b2b2[15]  -68.865  84.003  75.548  0.23 
p1b2b2[17]  p1b2b2[16]  -67.417  84.774  73.677  0.303 
p1b2b2[18]  p1b2b2[17]  -66.111  85.887  70.888  0.230 
p1b2b2[19]  p1b2b2[18]  -64.805  86.999  68.099  0.23 
p1b2b2[20]  p1b2b2[19]  -62.836  88.803  67.02  0.261 
p1b2b2[21]  p1b2b2[20]  -60.324  90.857  67.02  0.232 
p1b2b2[22]  p1b2b2[21]  -57.47  92.458  67.02  0.230 
p1b2b2[23]  p1b2b2[22]  -55.381  94.893  67.02  0.235 
p1b2b2[24]  p1b2b2[23]  -53.314  97.424  67.02  0.230 
p1b2b2[25]  p1b2b2[24]  -50.996  99.444  66.073  0.234 
p1b2b2[26]  p1b2b2[25]  -48.62  101.316  64.82  0.23 
p1b2b2[27]  p1b2b2[26]  -46.597  103.774  65.104  0.236 
p1b2b2[28]  p1b2b2[27]  -44.65  106.44  65.66  0.23 
