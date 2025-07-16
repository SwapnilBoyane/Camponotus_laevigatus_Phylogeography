#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=depth_species
#SBATCH --nodes=1 --ntasks=2
#SBATCH --partition=quanah
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G


conda activate samtools

# Set working directory
workdir=/lustre/scratch/sboyane/camplaevi/01_blochmannia

# Calculate the depth of coverage per site
samtools depth -a ${workdir}/02_bam_files > ${workdir}/depth/species_depth.txt

# Isolate the third column with the read counts only to reduce file size
cut -f3 ${workdir}/depth/species_depth.txt > ${workdir}/depth/species_depth_reduced.txt

# Remove the full depth file
rm ${workdir}/depth/species_depth.txt
