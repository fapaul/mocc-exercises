run() 
{
    cmd=$1
    output=$2
    end=$((SECONDS+10))
    VALUES=()
    while [ $SECONDS -lt $end ]; do
        VALUES+=( $($cmd) )
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
      val="${arr[ $((($nel/2)-1)) ]}"
  fi
  echo $val
}
