#!/bin/bash
#$ -N PRScs_job_array
#$ -o scripts/out_${JOB_ID}_${TASK_ID}.out
#$ -e scripts/out_${JOB_ID}_${TASK_ID}.err
#$ -tc 10  # Limit the number of concurrent tasks
#$ -l h_rt=10:00:00
#$ -l mem_free=100G
#$ -cwd

## Change the following statements:
DATA_SOURCE="BBJ"
METHOD="PRScs"
POPULATION="EUR"




# Source the Conda and Mamba setup scripts
source /wynton/protected/home/rotation/noahbaker/miniforge3/etc/profile.d/conda.sh
if [ -f "/wynton/protected/home/rotation/noahbaker/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/wynton/protected/home/rotation/noahbaker/miniforge3/etc/profile.d/mamba.sh"
    echo "Mamba sourced"
fi

# Activate the Conda environment using Mamba
mamba activate bmi206 || { echo "Failed to activate Mamba environment"; exit 1; }
echo "Activated bmi206 env"

# Assuming the environment is already set up correctly
DIRS=($DATA_SOURCE/*/)
INPUT_DIR="${DIRS[$((SGE_TASK_ID-1))]}"
INPUT_DIR="${INPUT_DIR%/}"  # Normalize INPUT_DIR to not end with a slash
echo "After normalization: $INPUT_DIR"

# Ensure the output directory exists
OUTPUT_DIR="out_${DATA_SOURCE}"
mkdir -p "$OUTPUT_DIR"
echo "Checked for the output dirs"

# Set the folder name from the directory name
FOLDER_NAME="${INPUT_DIR##*/}"
echo "Set the folder name: $FOLDER_NAME"

# Find the 'cl_*' file within the input directory
SST_FILES=$(find "$INPUT_DIR" -type f -name "cl_*")
if [ $(echo $SST_FILES | wc -w) -gt 1 ]; then
    echo "Error: Multiple 'cl_*' files found, specify which one to use."
    exit 1
fi
SST_FILE=$SST_FILES
echo "cl_ file located: $SST_FILE"

echo "Running PRScs"

# Run the Python script with the provided parameters
python3 /wynton/scratch/BMI206_NIC/tools/${METHOD}/${METHOD}.py \
    --ref_dir=/wynton/scratch/BMI206_NIC/ref_datasets/1KG_datasets \
    --bim_prefix=/wynton/scratch/BMI206_NIC/naracGenos-gaw16raw \
    --sst_file=/wynton/scratch/BMI206_NIC/${SST_FILE} \
    --n_gwas=1000 \
    --phi=1e-2 \
    --out_dir=/wynton/scratch/BMI206_NIC/output_${DATA_SOURCE} 
[imittra@dev1 BMI206_NIC]$ 
[imittra@dev1 BMI206_NIC]$ 
[imittra@dev1 BMI206_NIC]$ 
[imittra@dev1 BMI206_NIC]$ 
[imittra@dev1 BMI206_NIC]$ 
[imittra@dev1 BMI206_NIC]$ 
[imittra@dev1 BMI206_NIC]$ 
[imittra@dev1 BMI206_NIC]$ vim parallel_prscs.sh 
[imittra@dev1 BMI206_NIC]$ vim parallel_prsice.sh 

#!/bin/bash
#$ -N PRSice_job_array
#$ -o scripts/out_${JOB_ID}_${TASK_ID}.out
#$ -e scripts/out_${JOB_ID}_${TASK_ID}.err
#$ -tc 10  # Limit the number of concurrent tasks
#$ -l h_rt=10:00:00
#$ -l mem_free=100G
#$ -cwd

## Change the following statements:
DATA_SOURCE="BBJJ"
METHOD="PRSice"




# Source the Conda and Mamba setup scripts
source /wynton/protected/home/rotation/noahbaker/miniforge3/etc/profile.d/conda.sh
if [ -f "/wynton/protected/home/rotation/noahbaker/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/wynton/protected/home/rotation/noahbaker/miniforge3/etc/profile.d/mamba.sh"
    echo "Mamba sourced"
fi

# Activate the Conda environment using Mamba
mamba activate bmi206 || { echo "Failed to activate Mamba environment"; exit 1; }
echo "Activated bmi206 env"

# Assuming the environment is already set up correctly
DIRS=($DATA_SOURCE/*/)
INPUT_DIR="${DIRS[$((SGE_TASK_ID-1))]}"
INPUT_DIR="${INPUT_DIR%/}"  # Normalize INPUT_DIR to not end with a slash
echo "After normalization: $INPUT_DIR"

# Ensure the output directory exists
OUTPUT_DIR="out_${DATA_SOURCE}"
mkdir -p "$OUTPUT_DIR"
echo "Checked for the output dirs"

# Set the folder name from the directory name
FOLDER_NAME="${INPUT_DIR##*/}"
echo "Set the folder name: $FOLDER_NAME"

# Find the 'cl_*' file within the input directory
SST_FILES=$(find "$INPUT_DIR" -type f -name "cl_*")
if [ $(echo $SST_FILES | wc -w) -gt 1 ]; then
    echo "Error: Multiple 'cl_*' files found, specify which one to use."
    exit 1
fi
SST_FILE=$SST_FLES
echo "cl_ file located: $SST_FILE"

echo "Running PRSice"

# Run the R script with the provided parameters
Rscript /wynton/scratch/BMI206_NIC/tools/${METHOD}/${METHOD}.R  --dir . \
    --prsice ./PRSice \
    --base /wynton/scratch/BMI206_NIC/${SST_FILE} \
    --target /wynton/scratch/BMI206_NIC/naracGenos-gaw16raw.qc \
    --thread 1\
    --stat BETA\
    --beta\
    --binary-target F
