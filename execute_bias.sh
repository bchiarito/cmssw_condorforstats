#! /bin/bash
echo "Inside execute bias"
echo "Here there are all the input arguments:"
echo $@
echo ""
pwd
ls

echo "RUNBIAS.SH"
bash +x runbias.sh
echo ""
echo "Finished Run"
pwd
ls
echo ""
./drawbias.py fit*.root
echo ""
echo "Finished Draw"
pwd
ls plots
