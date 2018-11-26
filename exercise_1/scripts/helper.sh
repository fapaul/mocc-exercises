run() 
{
    cmd=$1
    output=$2
    end=$((SECONDS+2))
    VALUES=()
    while [ $SECONDS -lt $end ]; do
        VALUES+=( $($cmd) )
        #sleep 1
    done
    [ -e ./$output ] || echo "time,value" > $output 
    timestamp=$(date +"%s")","
    { printf $timestamp; median "${VALUES[@]}"; } >> $output
}

median() 
{
  arr=($(printf '%f\n' "${@}" | sort -n))
  nel=${#arr[@]}
  if (( $nel % 2 == 1 )); then     # Odd number of elements
    val="${arr[ $(($nel/2)) ]}"
  else                             # Even number of elements
    (( j=nel/2 ))
    (( k=j-1 ))
    (( val=(${arr[j]} + ${arr[k]})/2 ))
  fi
  echo $val
}
