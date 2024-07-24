## Setup

### Pythia8 submodule

We have to install Pythia8 ourselves for support for hepmc3 output. In principle Pythia8 is also available in LCG, but it is not compiled against hepmc3 to my knowledge, otherwise it would be possible...

The Pythia8 submodule was set up using
```
git submodule add https://gitlab.com/Pythia8/releases
git mv releases/ Pythia8
```
Other packages, like `hepmc3` or `lhapdf6` are not necessary to install as they are already available in `lcg` releases in `cvmfs`.

### Pythia8 installation

To install Pythia8, please follow the instructions below.
```
source /cvmfs/sft.cern.ch/lcg/views/LCG_106/x86_64-el9-gcc13-opt/setup.sh
cd Pythia8
git checkout pythia8312
# Note that you will get some weird yellow messages and Pythia8 complains a bit, but I do not understand why and it is working, so I do not care.
./configure --lcg=x86_64-el9-gcc13-opt --lcg-version=LCG_106 ./configure --with-gzip --with-hepmc3 --with-lhapdf6 --with-fastjet3 --with-root --with-python
make # accelerate with something like make -j 8 if you want
make install
```

In the repo, make sure to build the executable for showering the LHE events and check that there are no errors.
```
make
```

For good measure:
```
chmod +x shower_LHE
```

Make sure that the setup.sh is executable
```
chmod +x setup.sh
```

```
ls ../LHE_generation/output/ttH/*.lhe.gz > input_lists/lhe_files_ttH.txt
```