#!/bin/bash
memsweep()
{
    EXECUTABLE="memsweep"
    if [ ! -e $EXECUTABLE ] ; then
    	echo "Compiling memsweep.c"
    	cc -O -o memsweep memsweep.c -lm
    fi

    echo "Running memsweep benchmark"
    if [ "$SYSTEMROOT" = "C:\Windows" ] ; then
        result=$(./memsweep.exe | tail -1 | sed "s/[[:blank:]]\+/ /g" | cut -d " " -f 5)
    else
        result=$(./${EXECUTABLE} | tail -1 | sed "s/[[:blank:]]\+/ /g" | cut -d " " -f 5)
    fi

    echo $result
}