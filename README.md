# Advance Evol. Analysis 2026

## Counting reads in fastq files
Script used is in `scripts/read_count.slurm`
This script is written to be submitted to an HPC slurm. It uses arrays to quickly work through the fastq files, count the number of reads in each and saving it to a `.out` file the has the same name as the fastq file. The `.out` files are found in `fastq_counts` folder.
