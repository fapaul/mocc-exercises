start=$1
end=$2
gcc -o forksum forksum.c 
./forksum $start $end
rm forksum

