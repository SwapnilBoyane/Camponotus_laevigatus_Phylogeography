#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=filter
#SBATCH --nodes=1 --ntasks=1
#SBATCH --partition quanah
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-45
module load intel vcftools

# define input files from helper file during genotyping
#input_array=$( head -n${SLURM_ARRAY_TASK_ID} vcf_list.txt | tail -n1 )

# define main working directory
workdir=/lustre/scratch/sboyane/camplaevi/01_blochmannia

# run vcftools with SNP output spaced 20kbp 
vcftools --vcf ${workdir}/03_vcf/${input_array}.g.vcf --keep keeplist.txt --max-missing 1.0   --minDP 6 --max-meanDP 50 --min-alleles 2 --max-alleles 2 --mac 1 --thin 20000 --max-maf 0.49  --recode --recode-INFO-all --out ${workdir}/04_related_vcf_20kbp/${input_array}


# run bcftools to simplify the vcftools output for the 20kbp spacing for each species
bcftools query -f '%CHROM\t%POS\t%REF\t%ALT[\t%GT]\n ' ${workdir}/04_related_vcf_20kbp/relatedness.all.vcf > ${workdir}/04_related_vcf_20kbp/relatedness.simple.vcf


