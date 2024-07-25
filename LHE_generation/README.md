Setup environment:
source /cvmfs/sft.cern.ch/lcg/views/LCG_106/x86_64-el9-gcc13-opt/setup.sh

Prepare the gridpacks
```
mg5_aMC ttH.mg5
mg5_aMC tHq.mg5
```

Make sure that the gridpack runner scripts are executable:
```
chmod +x ./run_gridpack_ttH.sh
chmod +x ./run_gridpack_tHq.sh
```

Prepare the output directory for the events
```
mkdir output
mkdir output/ttH
mkdir output/tHq
```

Also prepare the directories for log, out, and err files. Otherwise, the condor jobs will go on hold.
```
mkdir logs errs outs
```

Then, simply submit the gridpack jobs
```
condor_submit submit_ttH.sub
condor_submit submit_ttH.sub
```

Note: To unpack the lhe events and check them, one can use
```
zip -dk events_vw_xyz.lhe.gz
head events_vw_xyz.lhe -n 1000
```