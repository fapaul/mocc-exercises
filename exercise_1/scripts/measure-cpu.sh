source ./helper.sh
source ./linpack.sh

measurecpu()
{
    # Measures kflops
    # Result is taken from the last line
    result=$(linpack >&1 | tail -1)
    echo $result
}

# Add "time,value" header when first creating file
# -e returns true if file exists
[ -e ./cpu.csv ] || echo "time,value" > cpu.csv

# Unix timestamp with seconds 
timestamp=$(date +"%s")","

{ printf $timestamp; run measurecpu; } >> cpu.csv
