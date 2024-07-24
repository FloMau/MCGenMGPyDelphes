#!/bin/bash

# Source MadGraph
source /net/scratch_cms3a/spaeh/private/Software/MadGraph_v3_AL9/setup_MG5.sh

# Get Cluster and Process ID from arguments
CLUSTER_ID=$1
PROCESS_ID=$2

# Set directories
WORKDIR=$_CONDOR_SCRATCH_DIR
INITIALDIR=$_CONDOR_JOB_IWD

# Move to working directory
cd $WORKDIR

# Extract gridpack (the file is already in the current directory)
tar -zxvvf run_01_gridpack.tar.gz

# Compile
cd madevent/bin
./compile
cd -

# Set seed and number of events
SEED=$(date +%N)
NEVENTS=50000

# Run the script
./run.sh $NEVENTS $SEED

# Ensure the output directory exists
mkdir -p $INITIALDIR/output

# Rename and move the output file to the initial directory
#cp events.lhe.gz $WORKDIR/ttH_events_${CLUSTER_ID}_${PROCESS_ID}.lhe.gz

exit 0
