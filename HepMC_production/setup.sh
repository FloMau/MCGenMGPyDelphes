source /cvmfs/sft.cern.ch/lcg/views/LCG_106/x86_64-el9-gcc13-opt/setup.sh
# Set environment variables
export PYTHIA8=/net/scratch_cms3a/spaeh/private/PhD/Studies/PhoIsoStudies/Pythia8
export PATH=$PYTHIA8/bin:$PATH
export LD_LIBRARY_PATH=$PYTHIA8/lib:$LD_LIBRARY_PATH
export PYTHIA8DATA=$PYTHIA8/share/Pythia8/xmldoc