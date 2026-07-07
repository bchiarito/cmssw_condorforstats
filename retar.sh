#! /bin/sh
wd=$(pwd)
rm cmssw_tarball.tgz.bkup
mv cmssw_tarball.tgz cmssw_tarball.tgz.bkup

cd ../CMSSW_14_1_0_pre4/src/HiggsAnalysis/CombinedLimit/2prong/res/
git describe --tags --long > git_commit.log
cd $wd

tar --exclude-caches-all --exclude-vcs --exclude=src/HiggsAnalysis/CombinedLimit/.git --exclude=src/HiggsAnalysis/CombinedLimit/data --exclude=tmp --exclude=src/HiggsAnalysis/CombinedLimit/2prong/res/fitDiagnosticsTest*.root --exclude=src/HiggsAnalysis/CombinedLimit/2prong/res/higgsCombineTest*.root --exclude=src/HiggsAnalysis/CombinedLimit/2prong/res/*workspace.root --exclude=src/HiggsAnalysis/CombinedLimit/2prong/res/roostats*.root --exclude=src/HiggsAnalysis/CombinedLimit/2prong/res/plots* --exclude=src/HiggsAnalysis/CombinedLimit/2prong/res/playing --exclude=src/HiggsAnalysis/CombinedLimit/2prong/res/input --exclude=src/HiggsAnalysis/CombinedLimit/2prong/res/newcard* -zcvf cmssw_tarball.tgz ../CMSSW_14_1_0_pre4
