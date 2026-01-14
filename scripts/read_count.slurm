#!/bin/bash

#SBATCH --job-name read_count
#SBATCH -A evoanalysis
#SBATCH -t 0-4:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=8G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=cnyam@uwyo.edu
#SBATCH -e /project/evoanalysis/cnyam/evoanalysis2026/reports/err_read_count_%A_%a.err
#SBATCH -o /project/evoanalysis/cnyam/evoanalysis2026/reports/std_read_count_%A_%a.out
#SBATCH --array=0-37

# Output directory
OUTDIR=/project/evoanalysis/cnyam/evoanalysis2026/fastq_counts/
# This creates the output directory if it is not already created
mkdir -p $OUTDIR

# Input directory, where fastq files are
INDIR=/project/evoanalysis/d3challenge_fq/

# Get list of all fastq files
FILE_LIST=($INDIR*.fastq)

# Select each file using the slurm array index (0-37 i.e., 38 in all)
FILE=${FILE_LIST[$SLURM_ARRAY_TASK_ID]}
# Extract file name without path
FILENAME=$(basename $FILE)
# Extract the unique filename to be used to create outfiles
NAME=${FILENAME%.combined_final.fastq}

# Reports file names. Checks to ensure everything up to this point is working 
echo "Working on $FILENAME to output ${NAME}.out in $OUTDIR"

# Using awk to count the reads each fastq and output to ${NAME}.out
awk 'END{print NR/4}' $FILE >> ${OUTDIR}${NAME}.out

# Alternative way. But may count quality lines that begin with @ 
# Using grep with -c to count the reads each fastq and output to ${NAME}.out
# grep -c '^@' $FILE >> ${OUTDIR}${NAME}.out

# Report job done
echo "Job complete"
