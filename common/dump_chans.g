// Script to write channel tables into ascii file to use in matlab.
// C. Gunay <cgunay@emory.edu> 2007/02/26
// $Id: dump_chans.g,v 1.1 2007/03/06 17:24:23 cengiz Exp $

function usage
  echo "Usage: dump_chans_func file_name output_type"
  echo "where"
  echo "  output_type: 'text' or 'matlab'."
  echo "  file_name: output file with channel tables."  
end

// var_name can be "minf" or "tau"
function dump_chan_gate_var(soma_chan_name, gate_name, var_name, file_name, output_type)
  str chan_name = {getpath {soma_chan_name} -tail}
  str id = "tables." @ {chan_name} @ "." @ {gate_name} @ "_" @ {var_name}
  str table2

  if ( {output_type} == "text")
    echo {id} @ ":" >> {file_name}
    echo {{chan_name} @ ":" } 
  elif ( {output_type} == "matlab" )
    echo {id} " = [" >> {file_name}
  end

  // dump table
  echo {file_name} {soma_chan_name} { {gate_name} @ "_A" } "_mode"  {var_name}

  // no table2 in tau
  if ( {var_name} == "tau" )
    tab2file {file_name} {soma_chan_name} { {gate_name} @ "_A" } -mode {var_name}
  else
    tab2file {file_name} {soma_chan_name} { {gate_name} @ "_A" } -table2 { {gate_name} @ "_B" } -mode {var_name}
  end

  // end of table
  if ( {output_type} == "text")
    echo >> {file_name}
  elif ( {output_type} == "matlab" )
    echo "];" >> {file_name}
  end

end

// dumps both minf and tau of one gate
function dump_chan_gate(soma_chan_name, gate_name, file_name, output_type)
  // if gate allocated?
  if ( {getfield {soma_chan_name} { {gate_name} @ "_alloced" }} == 1 )
    dump_chan_gate_var {soma_chan_name} {gate_name} "minf" {file_name} {output_type}
    dump_chan_gate_var {soma_chan_name} {gate_name} "tau" {file_name} {output_type}
  end
end

// Main function
function dump_chans_func(file_name, output_type)

if ( ( {output_type} == "" ) || ( {file_name} == "" ))
  echo "*** Error: need arguments."
  echo
  usage
  return
elif ( ( {output_type} != "matlab" ) && ( {output_type} != "text" ))
  echo "*** Error: output_type not recognized."
  echo
  usage
  return
end

str soma_chan_name, chan_name, dend_name, chan_names
float g_total_soma, g_total_dend, g_total_axIS, g_total_axHill

if ( {output_type} == "matlab")
  chan_names = "chan_names = {"
end

foreach soma_chan_name ({el /GP/soma/#[][CLASS=channel][OBJECT!=nernst]})

  chan_name = {getpath {soma_chan_name} -tail}
  if ( {output_type} == "text")
    echo {{chan_name} @ ":" } 
  elif ( {output_type} == "matlab" )
    chan_names = { {chan_names} @ ", '" @ {chan_name} @ "'" }
  end

  dump_chan_gate {soma_chan_name} "X" {file_name} {output_type}
  dump_chan_gate {soma_chan_name} "Y" {file_name} {output_type}
  dump_chan_gate {soma_chan_name} "Z" {file_name} {output_type}

end

if ( {output_type} == "matlab")
  chan_names = { {chan_names} @ "};"}
  echo { chan_names } >> {file_name}
end

end

echo "Call dump_chans_func"
usage

