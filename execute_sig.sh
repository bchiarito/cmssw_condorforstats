#! /bin/bash
echo "Inside execute sig"
echo "Here there are all the input arguments:"
echo $@
echo ""
pwd
ls

echo "RUNTOYSIGS.SH"
bash +x runtoysigs.sh
echo ""
echo "Finished Run"
pwd
ls
echo ""
