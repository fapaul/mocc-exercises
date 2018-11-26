source ./helper.sh
source ./memsweep.sh

measuremem()
{
    # Collects memsweep and return single value to be consumed by helper, which calculates median
    # Result is taken from the last line
    result=$(memsweep >&1 | tail -1)
    echo $result
}

# Add "time,value" header when first creating file
# -e returns true if file exists
[ -e ./mem.csv ] || echo "time,value" > mem.csv

# Unix timestamp with seconds 
timestamp=$(date +"%s")","

# printf does not add linebreak
{ printf $timestamp; run measuremem; } >> mem.csv
