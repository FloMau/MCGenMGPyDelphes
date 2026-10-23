# MCGenMGPyDelphes

This repository contains the code used to generate the tHq and ttH samples with MadGraph5_aMC@NLO, Pythia8 and Delphes for the following paper:

```bibtex
@article{Erdmann:2024unt,
    author = {Erdmann, Johannes and Mausolf, Florian and Sp{\"a}h, Jan Lukas},
    title = "{KAN We Improve on HEP Classification Tasks? Kolmogorov{\textendash}Arnold Networks Applied to an LHC Physics Example}",
    eprint = "2408.02743",
    archivePrefix = "arXiv",
    primaryClass = "hep-ph",
    doi = "10.1007/s41781-025-00138-3",
    journal = "Comput. Softw. Big Sci.",
    volume = "9",
    number = "1",
    pages = "9",
    year = "2025"
}
```

The event selection and machine learning analysis are available in [KANs_in_HEP](https://github.com/FloMau/KANs_in_HEP). The sample generation code is based on [HEP_Sample_Production](https://github.com/JaLuka98/HEP_Sample_Production).

The workflow has two stages with more technical READMEs included:

1. [LHE_generation/](LHE_generation/) contains the MadGraph process cards for proton–proton collisions at 14 TeV, including semi-leptonic top decays. The `run_gridpack_tHq.sh` and `run_gridpack_ttH.sh` scripts generate LHE events from gridpacks; the corresponding `.sub` files submit the jobs with HTCondor.
2. [PythiaDelphes/](PythiaDelphes/) handles showering, hadronisation and detector simulation. `shower_LHE.cpp` runs Pythia8 with the Higgs decay fixed to two photons and writes HepMC files; `runPythiaAndDelphes.sh` then runs Delphes with `my_delphes_card_CMS.tcl` to produce ROOT files.

The scripts use the CERN LCG_106 software stack through CVMFS and a separately compiled Pythia8 submodule with HepMC3 support. Initialise the submodule after cloning:

```bash
git submodule update --init --recursive
```

Setup and job submission instructions are in [LHE_generation/README.md](LHE_generation/README.md) and [PythiaDelphes/README.md](PythiaDelphes/README.md). Adjust the absolute paths in `PythiaDelphes/setup.sh`, `PythiaDelphes/runPythiaAndDelphes.sh` and the HTCondor submission files to your local setup before running.
