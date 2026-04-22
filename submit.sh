#/bin/sh
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <bias|limits> <jobname>"
    exit 1
fi
if [ "$1" != "bias" ] && [ "$1" != "limits" ]; then
    echo "Error: first argument must be 'bias' or 'limits'."
    exit 1
fi
Parent="Jobs"
if [ -d $Parent/$2 ]; then
    echo "Error: Job Directory with name already exists."
    exit 1
fi
cat <(echo "TYPE=$1") submit.jdl > tmp.jdl
cat <(echo "Parent=$Parent") tmp.jdl > tmp2.jdl
rm tmp.jdl
mkdir $Parent/$2
cp setup_$1.sh $Parent/$2
cp execute.sh $Parent/$2
cp execute_$1.sh $Parent/$2
cp tmp2.jdl $Parent/$2/submit.jdl
condor_submit tmp2.jdl jobname=$2
rm tmp2.jdl
