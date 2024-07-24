#!/bin/bash

MAINDIR=$PWD/ttH_gridpack_dir

# create directory and compile
mkdir -p run_dir
cd run_dir
cp $MAINDIR/run_01_gridpack.tar.gz .
tar -zxvvf run_01_gridpack.tar.gz
cd madevent/bin
./compile
cd -

SEED=`date +%N` # time in nanosecons
NEVENTS=50000
./run.sh $NEVENTS $SEED

exit 0
