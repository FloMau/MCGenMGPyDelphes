#!/bin/bash

echo "Starting job: $(date)"

# Ensure the executable and LHE file are provided as arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <shower_LHE_executable> <lhe_file>"
  exit 1
fi

# Assign input arguments to variables
SHOWER_LHE_EXE=$1
LHE_FILE=$2

# Extract the base name of the LHE file (without path and extension)
BASE_NAME=$(basename "$LHE_FILE" .lhe.gz)
echo "Base name of the LHE file: $BASE_NAME"

# Copy executable and LHE file to the current directory
echo "Copying executable and LHE file to the current directory..."
cp "$SHOWER_LHE_EXE" ./shower_LHE
cp "$LHE_FILE" .

# Unpack the LHE file
echo "Unpacking the LHE file..."
gzip -dk "$BASE_NAME.lhe.gz"

# Set up Pythia8
echo "Setting up Pythia8..."
source setup.sh

# Run the showering process
echo "Running the showering process with shower_LHE..."
./shower_LHE "$BASE_NAME.lhe"

# Clean up intermediate files if needed
echo "Cleaning up transferred files..."
rm "$BASE_NAME.lhe"
rm "$BASE_NAME.lhe.gz"

echo "Job completed: $(date)"
exit 0
