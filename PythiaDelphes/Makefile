# Define the compiler
CXX = g++

# Define the source and target files
SRC = shower_LHE.cpp
TARGET = shower_LHE

# Define the external configurations
PYTHIA8_CONFIG = $(shell pythia8-config --cxxflags --ldflags)
HEPMC3_CONFIG = $(shell HepMC3-config --cflags --libs)

# Compilation rule
$(TARGET): $(SRC)
	$(CXX) $(SRC) -o $(TARGET) $(PYTHIA8_CONFIG) $(HEPMC3_CONFIG)

# Clean rule
clean:
	rm -f $(TARGET)

.PHONY: clean
