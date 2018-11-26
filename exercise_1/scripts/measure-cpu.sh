source ./helper.sh
source ./linpack.sh

measurecpu()
{
    # Measures kflops
    # Result is taken from the last line
    result=$(linpack >&1 | tail -1)
    echo $result
}
run measurecpu "cpu.csv"
