#!/bin/bash

# Source MadGraph, using centrally available software stack :)
source /cvmfs/sft.cern.ch/lcg/views/LCG_106/x86_64-el9-gcc13-opt/setup.sh

# Get Cluster and Process ID from arguments
CLUSTER_ID=$1
PROCESS_ID=$2

# Set directories
WORKDIR=$_CONDOR_SCRATCH_DIR
INITIALDIR=$_CONDOR_JOB_IWD

# Move to working directory
cd $WORKDIR

# Extract gridpack (the file is already in the current directory since it has been transferred as input)
tar -zxvvf run_01_gridpack.tar.gz

# Compile
cd madevent/bin
./compile
cd -

# Set seed and number of events
SEED=$(date +%N)
NEVENTS=5000

# Run the script
./run.sh $NEVENTS $SEED

# Ensure the output directory exists
mkdir -p $INITIALDIR/output

# Rename and move the output file to the initial directory so that it can be transferred by htcondor
cp events.lhe.gz $WORKDIR/tHq_events_${CLUSTER_ID}_${PROCESS_ID}.lhe.gz

exit 0
