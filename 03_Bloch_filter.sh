#!/bin/sh
#SBATCH --chdir=.
#SBATCH --job-name=filter
#SBATCH --nodes=1 --ntasks=1
#SBATCH --partition quanah
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G

module load intel vcftools
module load intel bcftools

# define main working directory
workdir=/lustre/scratch/sboyane/blocmannia

#run vcftools with SNP output spaced 20kbp
#for PCA, EEMS, IBD 
vcftools --vcf ${workdir}/03_vcf/blochmannia_final.g.vcf --keep keeplist_pca.txt --max-missing 1.0   --minDP 50  --min-alleles 2 --max-alleles 2 --mac 2  --max-maf 0.49  --recode --recode-INFO-all --out ${workdir}/04_filtered_vcf/blochmannia_final

# run vcftools with SNP and invariant site output, 20% max missing data, no indels 
#for Phylogeny 
vcftools --vcf ${workdir}/03_vcf/blochmannia_final.g.vcf --max-missing 0.8 --minGQ 20 --minDP 50  --max-alleles 2  --max-maf 0.49 --remove-indels --recode --recode-INFO-all --out ${workdir}/05_phylo_vcf/blochmannia_final_phylo



# bgzip and tabix index files that will be subdivided into windows
# directory 1
/lustre/work/johruska/miniconda2/bin/bgzip ${workdir}/05_phylo_vcf/blochmannia_final_phylo.recode.vcf
#tabix
/lustre/work/johruska/miniconda2/bin/tabix -p vcf ${workdir}/05_phylo_vcf/blochmannia_final_phylo.recode.vcf.gz