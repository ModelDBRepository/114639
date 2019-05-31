//FILE IN USE 05/24/2004 -- present.

//genesis

/* This script reads parameters from an asci file
** The first line needs to contain the number of parameter lines 
** as the first argument, and the number of parameters in each line
** as the second argument
** Each subsequent line contains a list of 1-20 parameters, and as last
** item on the line also contains a 0
** The getfilepar function replaces the 0 with a 1 for lines that
** have been processed 
** The user needs to have write permission to the current directory
*/


str filepar1, filepar2, filepar3, filepar4, filepar5, filepar6
str filepar7, filepar8, filepar9, filepar10
str filepar11, filepar12, filepar13, filepar14, filepar15, filepar16
str filepar17, filepar18, filepar19, filepar20

function getfilepar (fname)
str fname

// This function reads a command file
// and sets a simulation parameter to the
// first value in the command file, that
// is not followed by a 1 as second value in a line
// It then rewrites the command file to reflect
// the processing of the current parameter

/* LOCK FILE */
// str lockFile = {fname} @ ".lock"
// while ({ls {lockFile}} != 256)
//  echo Waiting for lock release ...
// end
// touch {lockFile}

// clearerrors

str tmpfname

tmpfname = {fname} @ ".tmp"

openfile {fname} r
openfile {tmpfname} w

str instr
int lines
int nopar
int i
int done = 0
int control
str parstr

instr = {readfile {fname} -l}
writefile {tmpfname} {instr}

lines = {getarg {arglist {instr}} -arg 1}
nopar = {getarg {arglist {instr}} -arg 2}

for(i=0; i < lines; i = i + 1)
instr = {readfile {fname} -l}

if(done == 1)
	writefile {tmpfname} {instr}
else
	filepar1 = {getarg {arglist {instr}} -arg 1}
	parstr = {filepar1}
	if(nopar > 1) 
	filepar2 = {getarg {arglist {instr}} -arg 2}
	parstr = {parstr} @ " " @ {filepar2}
	end
	if(nopar > 2) 
	filepar3 = {getarg {arglist {instr}} -arg 3}
	parstr = {parstr} @ " " @ {filepar3}
	end
	if(nopar > 3) 
	filepar4 = {getarg {arglist {instr}} -arg 4}
	parstr = {parstr} @ " " @ {filepar4}
	end
	if(nopar > 4) 
	filepar5 = {getarg {arglist {instr}} -arg 5}
	parstr = {parstr} @ " " @ {filepar5}
	end
	if(nopar > 5) 
	filepar6 = {getarg {arglist {instr}} -arg 6}
	parstr = {parstr} @ " " @ {filepar6}
	end
	if(nopar > 6) 
	filepar7 = {getarg {arglist {instr}} -arg 7}
	parstr = {parstr} @ " " @ {filepar7}
	end
	if(nopar > 7) 
	filepar8 = {getarg {arglist {instr}} -arg 8}
	parstr = {parstr} @ " " @ {filepar8}
	end
	if(nopar > 8) 
	filepar9 = {getarg {arglist {instr}} -arg 9}
	parstr = {parstr} @ " " @ {filepar9}
	end
	if(nopar > 9) 
	filepar10 = {getarg {arglist {instr}} -arg 10}
	parstr = {parstr} @ " " @ {filepar10}
	end
        if(nopar > 10)
        filepar11 = {getarg {arglist {instr}} -arg 11}
        parstr = {parstr} @ " " @ {filepar11}
        end
        if(nopar > 11)
        filepar12 = {getarg {arglist {instr}} -arg 12}
        parstr = {parstr} @ " " @ {filepar12}
        end
        if(nopar > 12)
        filepar13 = {getarg {arglist {instr}} -arg 13}
        parstr = {parstr} @ " " @ {filepar13}
        end
        if(nopar > 13)
        filepar14 = {getarg {arglist {instr}} -arg 14}
        parstr = {parstr} @ " " @ {filepar14}
        end
        if(nopar > 14)
        filepar15 = {getarg {arglist {instr}} -arg 15}
        parstr = {parstr} @ " " @ {filepar15}
        end
        if(nopar > 15)
        filepar16 = {getarg {arglist {instr}} -arg 16}
        parstr = {parstr} @ " " @ {filepar16}
        end
        if(nopar > 16)
        filepar17 = {getarg {arglist {instr}} -arg 17}
        parstr = {parstr} @ " " @ {filepar17}
        end
        if(nopar > 17)
        filepar18 = {getarg {arglist {instr}} -arg 18}
        parstr = {parstr} @ " " @ {filepar18}
        end
        if(nopar > 18)
        filepar19 = {getarg {arglist {instr}} -arg 19}
        parstr = {parstr} @ " " @ {filepar19}
        end
        if(nopar > 19)
        filepar20 = {getarg {arglist {instr}} -arg 20}
        parstr = {parstr} @ " " @ {filepar20}
        end

	control = {getarg {arglist {instr}} -arg {{nopar}+1}}

	if(control == 1)
		writefile {tmpfname} {instr}
	else
		writefile {tmpfname} {parstr} 1
		done = 1
	end
		
end

end

closefile {fname}
closefile {tmpfname}
cp {tmpfname} {fname}
if(done == 0)
    echo -------------------------------------------------------
    echo No more parameters in command file, quitting simulation
    echo -------------------------------------------------------
    quit
end

end
