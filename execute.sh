#! /bin/bash
#!/bin/bash
echo ">>> Starting job on" `date`
echo ">>> Running on: `uname -a`"
echo ">>> System software: `cat /etc/redhat-release`"
echo ""
echo "Here there are all the input arguments:"
echo $@
echo ""
pwd
ls

export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
export SCRAM_ARCH=el8_amd64_gcc12
source $VO_CMS_SW_DIR/cmsset_default.sh

tar -xf cmssw_tarball.tgz
rm cmssw_tarball.tgz ###note if you do this locally you remove possibly IMPORTANT FILES always be careful with "rm"
cd CMSSW_14_1_0_pre4/src/
scramv1 b ProjectRename # this handles linking the already compiled code - do NOT recompile
eval `scramv1 runtime -sh` # cmsenv is an alias not on the workers
echo $CMSSW_BASE "is the CMSSW we have on the local worker node"
#cd ${_CONDOR_SCRATCH_DIR}
cd HiggsAnalysis/CombinedLimit
cd 2prong/res/

echo ""
rm setup_$1.sh
cp ${_CONDOR_SCRATCH_DIR}/setup_$1.sh .
cp ${_CONDOR_SCRATCH_DIR}/execute_$1.sh .
cp -r ${_CONDOR_SCRATCH_DIR}/input .
ls
echo ""
echo "input/:"
ls -l input/*
echo ""
#source setup_$1.sh
echo ""

if [ ${1} == "bias" ]; then
. ./execute_bias.sh
elif [ ${1} == "limits" ]; then
. ./execute_limits.sh
fi

export WORK_DIR=$(pwd)
cd ${_CONDOR_SCRATCH_DIR}
mkdir joboutput
cd joboutput
cp $WORK_DIR/*.root .
cp $WORK_DIR/plots_$1/* .
cp $WORK_DIR/*.pdf .
