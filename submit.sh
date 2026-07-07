#/bin/sh
if [ "$#" -ne 2 ] && [ "$#" -ne 3 ]; then
    echo "Usage: $0 <bias|limits|sig> <jobname> <njobs=1>"
    exit 1
fi
if [ "$1" != "bias" ] && [ "$1" != "limits" ] && [ "$1" != "sig" ] ; then
    echo "Error: first argument must be 'bias' or 'limits' or 'sig'."
    exit 1
fi
Parent="Jobs"
if [ -d $Parent/$2 ]; then
    echo "Error: Job Directory with name already exists."
    #rm -rf $Parent/$2
    exit 1
fi

cat <(echo "TYPE=$1") submit.jdl > tmp.jdl
cat <(echo "Parent=$Parent") tmp.jdl > tmp2.jdl
rm tmp.jdl

if [ "$#" -eq 2 ]; then
    njobs=1
fi
if [ "$#" -eq 3 ]; then
    njobs=$3
fi
src="setup_$1.sh"

# Source the original to get the actual masses array
source $src &> /dev/null

total=${#masses[@]}
# Ceiling division: chunk size per job
chunk=$(( (total + njobs - 1) / njobs ))

for (( i=0; i<njobs; i++ )); do
    start=$(( i * chunk ))
    # Stop if we've run out of elements (when njobs > total)
    if (( start >= total )); then
        njobs=$((i))
        break
    fi

    # Slice out this job's portion
    sub=("${masses[@]:start:chunk}")
    new_line="masses=(${sub[*]})"

    out="split_setup_$1_$((i)).sh"
    cp "$src" "$out"

    # Replace the original masses=... line with the explicit list
    # Use a different delimiter since the replacement may contain special chars
    #sed -i "s|^masses=(\$(seq .*|${new_line}|" "$out"
    sed -i "s|^masses=(.*|${new_line}|" "$out"

    if [ "$njobs" -ne 1 ]; then
        #echo "Wrote $out with ${#sub[@]} elements: $new_line"
        echo "$new_line"
    fi
done

if [ "$njobs" -ne 1 ]; then
    read -p "Press [Enter] to continue or q to quit: " input
    if [[ "$input" == "q" ]]; then
        rm split_setup_$1_*.sh
        exit 0
    fi
fi

mkdir -p $Parent/$2
mkdir -p $Parent/$2/stdout
mkdir -p $Parent/$2/setup
cp setup_$1.sh $Parent/$2
cp split_setup_$1_*.sh $Parent/$2/setup/
cp execute.sh $Parent/$2
cp execute_$1.sh $Parent/$2
cp tmp2.jdl $Parent/$2/submit.jdl
condor_submit tmp2.jdl jobname=$2 -queue $njobs
rm tmp2.jdl
rm split_setup_$1_*.sh
