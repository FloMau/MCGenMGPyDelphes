Prepare the gridpack after setting up MadGraph5
```
mg5_aMC ttH.mg5
```

Make sure that the gridpack runner script is executable:
```
chmod +x ./run_gridpack.sh
```

Prepare the output directory for the events
```
mkdir output
mkdir output/ttH
mkdir output/tHqb
```

Also prepare the directories for log, out, and err files. Otherwise, the condor jobs will go on hold.
```
mkdir logs errs outs
```

Then, simply submit the gridpack jobs
```
condor_submit submit_ttH.sub
```

Note: To unpack the lhe events and check them, one can use
```
zip -dk events_vw_xyz.lhe.gz
head events_vw_xyz.lhe -n 1000
```