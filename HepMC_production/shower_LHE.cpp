#include "Pythia8/Pythia.h"
#include "Pythia8Plugins/HepMC3.h"
#include <iostream>
#include <memory>
#include <string>

using namespace Pythia8;

std::string replaceExtension(const std::string& filename, const std::string& oldExt1, const std::string& oldExt2, const std::string& newExt) {
    if (filename.size() >= oldExt1.size() && filename.compare(filename.size() - oldExt1.size(), oldExt1.size(), oldExt1) == 0) {
        return filename.substr(0, filename.size() - oldExt1.size()) + newExt;
    } else if (filename.size() >= oldExt2.size() && filename.compare(filename.size() - oldExt2.size(), oldExt2.size(), oldExt2) == 0) {
        return filename.substr(0, filename.size() - oldExt2.size()) + newExt;
    } else {
        throw std::runtime_error("Input file must have extension .lhe or .lhe.gz");
    }
}

int main(int argc, char* argv[]) {
    // Check for input file argument
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <input file (.lhe or .lhe.gz)>" << std::endl;
        return 1;
    }

    std::string inputFilename = argv[1];
    std::string outputFilename;

    try {
        outputFilename = replaceExtension(inputFilename, ".lhe", ".lhe.gz", ".hepmc");
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return 1;
    }

    // You can always read an plain LHE file,
    // but if you ran "./configure --with-gzip" before "make"
    // then you can also read a gzipped LHE file.
#ifdef GZIPSUPPORT
    bool useGzip = true;
#else
    bool useGzip = false;
#endif
    std::cout << "useGzip = " << useGzip << std::endl;

    // Generator. We here stick with default values, but changes
    // could be inserted with readString or readFile.
    Pythia pythia;

    // Initialize Les Houches Event File run. List initialization information.
    pythia.readString("Beams:frameType = 4");
    pythia.readString("Beams:LHEF = " + inputFilename);
    pythia.init();

    // Set up output file
    HepMC3::Pythia8ToHepMC3 toHepMC;
    std::shared_ptr<HepMC3::Writer> hepmc_writer = std::make_shared<HepMC3::WriterAscii>(outputFilename);

    // Allow for possibility of a few faulty events.
    int nAbort = 10;
    int iAbort = 0;

    // Begin event loop; generate until none left in input file.
    for (int iEvent = 0; iEvent < 500; ++iEvent) {
        // Print status update every 100 events
        if (iEvent % 100 == 0) {
            std::cout << "INFO: Processed " << iEvent << " ..." << std::endl;
        }

        // Generate events, and check whether generation failed.
        if (!pythia.next()) {
            // If failure because reached end of file then exit event loop.
            if (pythia.info.atEndOfFile()) break;

            // First few failures write off as "acceptable" errors, then quit.
            if (++iAbort < nAbort) continue;
            break;
        }

        HepMC3::GenEvent hepmc_event;
        toHepMC.fill_next_event(pythia, &hepmc_event);
        hepmc_writer->write_event(hepmc_event);
    }

    // Done.
    return 0;
}
