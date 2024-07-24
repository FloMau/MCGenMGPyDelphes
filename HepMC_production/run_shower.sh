#!/bin/bash

echo "Starting job: $(date)"

# Ensure the executable and LHE file are provided as arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <shower_LHE_executable> <lhe_file>"
  exit 1
fi

# Move to Condor's scratch directory
cd "$_CONDOR_SCRATCH_DIR"
echo "Running in directory: $(pwd)"

# Assign input arguments to variables
SHOWER_LHE_EXE=$1
LHE_FILE=$2

# Extract the base name of the LHE file (without path and extension)
BASE_NAME=$(basename "$LHE_FILE" .lhe.gz)
echo "Base name of the LHE file: $BASE_NAME"

# Unpack the LHE file
echo "Unpacking the LHE file..."
gzip -dk "$BASE_NAME.lhe.gz"
if [ $? -ne 0 ]; then
  echo "Failed to unpack the LHE file."
  exit 1
fi

# Set up Pythia8
echo "Setting up Pythia8..."
source setup.sh
if [ $? -ne 0 ]; then
  echo "Failed to set up Pythia8."
  exit 1
fi

# Run the showering process
echo "Running the showering process with shower_LHE..."
./shower_LHE "$BASE_NAME.lhe" 2>&1 | tee shower_LHE.log
if [ $? -ne 0 ]; then
  echo "shower_LHE failed."
  exit 1
fi

# Clean up intermediate files if needed
echo "Cleaning up intermediate files..."
rm "$BASE_NAME.lhe"
rm "$BASE_NAME.lhe.gz"
if [ $? -ne 0 ]; then
  echo "Failed to clean up intermediate files."
  exit 1
fi

echo "Job completed: $(date)"
exit 0
