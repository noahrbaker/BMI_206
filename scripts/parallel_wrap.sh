#!/bin/bash

# Calculate the number of directories
NUM_DIRS=$(ls -d BBJ/*/ | wc -l)
echo "Number of directories: $NUM_DIRS"

# Submit the job, passing the calculated number of directories
qsub -t 1-$NUM_DIRS parallel_jobs.sh
