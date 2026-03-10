#! /bin/bash
echo "Inside execute limits"
echo "Here there are all the input arguments:"
echo $@
echo ""
pwd
ls

echo "RUNLIMITS.SH"
bash +x runlimits.sh
echo ""
echo "Finished Run"
pwd
ls
echo ""
./drawlimits.py higgsCombineTest.AsymptoticLimits*.root
echo ""
echo "Finished Draw"
pwd
ls *.pdf
