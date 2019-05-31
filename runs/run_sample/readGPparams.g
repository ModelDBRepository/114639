// ************************************************************
// Reads variables from a parameter row (parrow) variable.
// ---
// C. Gunay, 2006/01/25
// $Id: readGPparams.g,v 1.3 2007/03/09 23:53:59 cengiz Exp $
// ************************************************************

// Read the morphology first
str morph_name
int morph_num =		{getarg {arglist {parrow}} -arg 10}
if ({morph_num} == 1)
  include ../../common/GP1_defaults.g
  morph_name = "GP1"
elif ({morph_num} == 2)
  include ../../common/GP4_defaults.g
  morph_name = "GP4"
elif ({morph_num} == 3)
  include ../../common/GP3_defaults.g
  morph_name = "GP3"
else
  echo "Morphology parameter " @ {morph_num} @ " is not recognized."
  exit
end

//initialize parameters
include ../../common/actpars.g

/* COMMENT
ALL intrinsic model params have now been initialized and set. 
They can be safely overwritten any time between now and the calling of
the make_GP_library file. Once the library has been created, parameter values
are set and cannot be changed except with explicit calls to setfield.
*/

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
float trialnum = 	{getarg {arglist {parrow}} -arg {trialparamnum}}
