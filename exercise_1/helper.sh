run() 
{
    cmd=$1
    end=$((SECONDS+20))
    VALUES=()
    while [ $SECONDS -lt $end ]; do
        VALUES+=( $($cmd) )
        #sleep 1
    done
    #echo ${VALUES[@]}
    median "${VALUES[@]}"
}

median() 
{
  arr=($(printf '%d\n' "${@}" | sort -n))
  nel=${#arr[@]}
  if (( $nel % 2 == 1 )); then     # Odd number of elements
    val="${arr[ $(($nel/2)) ]}"
  else                            # Even number of elements
    (( j=nel/2 ))
    (( k=j-1 ))
    (( val=(${arr[j]} + ${arr[k]})/2 ))
  fi
  echo $val
}

run "echo 1"
