source ./helper.sh


measuresequential()
{
    # 
    dd if=/dev/zero of=~/testfile bs=250M count=1 oflag=direct > disk-sequential-temp >&1
    # Take last line of output file and then extract 10th argument (write/read speed)
    result=$(cat disk-sequential-temp | tail -1 | cut -d " " -f 10)
    echo $result
}

# Add "time,value" header when first creating file
# -e returns true if file exists
[ -e ./results-measure-disk-random.csv ] || echo "time,value" > results-measure-disk-random.csv

# Unix timestamp with seconds 
timestamp=$(date +"%s")","

# printf does not add linebreak
# echo adds linebreak
# >> appends and does not overwrite file

# Combine these 2
dd if=/dev/zero of=~/testfile bs=250M count=1 oflag=direct > output >&1
# Take last line of output file and then extract 10th argument (write/read speed)
cat output | tail -n -1 | cut -d " " -f 10 > results-measure-disk-random.csv

{ printf $timestamp; run "dd if=/dev/zero of=~/testfile bs=250M count=1 oflag=direct"; } >> results-measure-disk-random.csv

# TODO: Only write last output of dd return
