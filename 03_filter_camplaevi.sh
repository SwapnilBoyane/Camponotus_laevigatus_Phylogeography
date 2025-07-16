#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=filter
#SBATCH --nodes=1 --ntasks=1
#SBATCH --partition quanah
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-45


module load intel vcftools
module load intel bcftools

# define input files from helper file during genotyping
input_array=$( head -n${SLURM_ARRAY_TASK_ID} vcf_list.txt | tail -n1 )

# define main working directory
workdir=/lustre/scratch/sboyane/camplaevi/01_blochmannia

#run vcftools with SNP output spaced 20kbp
#for ADMIXTURE, PCA, EEMS, IBD 
vcftools --vcf ${workdir}/03_vcf/${input_array}.g.vcf --keep keeplist.txt --max-missing 1.0   --minDP 6 --max-meanDP 50 --min-alleles 2 --max-alleles 2 --mac 2 --thin 20000 --max-maf 0.49  --recode --recode-INFO-all --out ${workdir}/05_20kbp_vcf/${input_array}

# run vcftools with SNP output spaced 20kbp 
#for relatedness 
vcftools --vcf ${workdir}/03_vcf/${input_array}.g.vcf --keep keeplist.txt --max-missing 1.0   --minDP 6 --max-meanDP 50 --min-alleles 2 --max-alleles 2 --mac 1 --thin 20000 --max-maf 0.49  --recode --recode-INFO-all --out ${workdir}/04_related_vcf_20kbp/${input_array}

# run vcftools with SNP and invariant site output, 20% max missing data, no indels 
#for Phylogeny 
vcftools --vcf ${workdir}/03_vcf/${input_array}.g.vcf --max-missing 0.8 --minGQ 20 --minDP 6 --max-meanDP 50 --max-alleles 2  --max-maf 0.49 --remove-indels --recode --recode-INFO-all --out ${workdir}/phylo/${input_array}

# run vcftools with SNP and invariant site output, 20% max missing data, no indels
#for observed heterozygosity remove outgroup
vcftools --vcf ${workdir}/03_vcf/${input_array}.g.vcf --keep keeplist.txt --max-missing 0.8 --minGQ 20 --minDP 6 --max-meanDP 50 --max-alleles 2  --max-maf 0.49 --remove-indels --recode --recode-INFO-all --out ${workdir}/08_OH/${input_array}

# bgzip and tabix index files that will be subdivided into windows
# directory 1
bgzip ${workdir}/phylo/${input_array}.recode.vcf
#tabix
tabix -p vcf ${workdir}/phylo/${input_array}.recode.vcf.gz
