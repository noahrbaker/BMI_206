# BMI_206
Repository for BMI 206 Project to recreate Figure 3 for "Improving polygenic prediction in ancestrally diverse populations"

Ruan, Y., Lin, YF., Feng, YC.A. et al. Improving polygenic prediction in ancestrally diverse populations. Nat Genet 54, 573–580 (2022). https://doi.org/10.1038/s41588-022-01054-7


\n
The `data` directory contains the UKBB, PAGE, and BBJ files. They have been extracted from their compressed file structures, columns have been extracted, and the data has been cleaned.
\n
The `output` directory contains the output data from PRScs and PRScsx for each of the different `data` sources and their phenotypes. 
\n
The `ref_datasets` directory contains the information for the 1K Genome project data and the UKBB data to serve as references for running PRScs and PRScsx.
\n
The `tools` directory contains the various software used in the paper, including PRScs, PRScsx, and PRSice. These software are downloaded from their respective githubs. LDpred2 is available as an R library and is not downloaded separately. 
\n
The `scripts` directory contains some helper functions for extracting, cleaning the data, and running the software. The directory paths are messed up in the move to an organized github repo.
