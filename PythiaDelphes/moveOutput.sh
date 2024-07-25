# dirty fix since I do not have condor skills to make it move the output to the right locations...
mkdir -p output/ttH
mkdir -p output/tHq

mv ./tHq_events*.root output/tHq/
mv ./ttH_events*.root output/ttH/