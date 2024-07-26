## Setup

### Pythia8 submodule

We have to install Pythia8 ourselves for support for hepmc3 output. In principle Pythia8 is also available in LCG, but it is not compiled against hepmc3 to my knowledge, otherwise it would be possible...

The Pythia8 submodule was set up using
#### (no need to run this again)
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
make -j 8 # accelerate with something like make -j 8 if you want
make install
```

In the repo, make sure to build the executable for showering the LHE events and check that there are no errors.
```
cd ..
make -j 8
```

```
mkdir logs errs outs
```

For good measure:
```
chmod +x shower_LHE
```
Change the path of the delphes card to your local one in `runPythiaDelphes.sh`!
Change Pythia path in `setup.sh`!

Make sure that the setup.sh is executable
```
chmod +x setup.sh
```

#### to get a list of files to process:
```
mkdir input_lists -p
ls ../LHE_generation/output/ttH/*.lhe.gz > input_lists/lhe_files_ttH.txt
ls ../LHE_generation/output/tHq/*.lhe.gz > input_lists/lhe_files_tHq.txt
```


```
condor_submit submit_ttH.sub
condor_submit submit_tHq.sub
```

I did not manage to make HTCondor copy the output files automatically to the right location, so run this:
```
source moveOutput.sh
```