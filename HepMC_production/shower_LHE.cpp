#include "Pythia8/Pythia.h"
#include "Pythia8Plugins/HepMC3.h"
using namespace Pythia8;


int main() {

    // You can always read an plain LHE file,
    // but if you ran "./configure --with-gzip" before "make"
    // then you can also read a gzipped LHE file.
#ifdef GZIPSUPPORT
    bool useGzip = true;
#else
    bool useGzip = false;
#endif
    cout << " useGzip = " << useGzip << endl;

    // Generator. We here stick with default values, but changes
    // could be inserted with readString or readFile.
    Pythia pythia;

    // Initialize Les Houches Event File run. List initialization information.
    pythia.readString("Beams:frameType = 4");
    if (useGzip) pythia.readString("Beams:LHEF = ttbar.lhe.gz");
    else         pythia.readString("Beams:LHEF = ttbar.lhe");
    pythia.init();

    // Set up output file
    std::string filename = "enriched_dijet.hepmc";
    HepMC3::Pythia8ToHepMC3 toHepMC;
    std::shared_ptr<HepMC3::Writer> hepmc_writer = std::make_shared<HepMC3::WriterAscii>(filename);

    // Allow for possibility of a few faulty events.
    int nAbort = 10;
    int iAbort = 0;

    // Begin event loop; generate until none left in input file.
    for (int iEvent = 0; ; ++iEvent) {

        // Print status update every 1000 events
        if (iEvent % 1000 == 0) {
          std::cout << "Processed " << iEvent << std::endl;
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
