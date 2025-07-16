#!/bin/sh
#SBATCH --chdir=.
#SBATCH --job-name=step2
#SBATCH --nodes=1 --ntasks=8
#SBATCH --partition=quanah
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-30

module load intel java


input_array=$( head -n${SLURM_ARRAY_TASK_ID} basenames.txt | tail -n1 )

#step 1_array
/lustre/work/jmanthey/gatk-4.1.0.0/gatk --java-options "-Xmx64g" HaplotypeCaller -R /lustre/work/sboyane/ref/C145_quercicola.fasta  -I /lustre/scratch/sboyane/camplaevi/01_blochmannia/02_bam_files/${input_array}_final.bam -ERC GVCF -O /lustre/scratch/sboyane/camplaevi/01_blochmannia/02_vcf/${input_array}.g.vcf --ploidy 1 --QUIET


#step2_array
/lustre/work/jmanthey/gatk-4.1.0.0/gatk --java-options "-Xmx60g" GenomicsDBImport -V /lustre/scratch/sboyane/camplaevi/01_blochmannia/02_vcf/${input_array}.g.vcf --genomicsdb-workspace-path /lustre/scratch/sboyane/camplaevi/01_blochmannia/02_vcf/${input_array} -L helper5.list


#step3_array

/lustre/work/jmanthey/gatk-4.1.0.0/gatk --java-options "-Xmx80g" GenotypeGVCFs \
-R /lustre/work/sboyane/ref/C145_quercicola.fasta \
-V gendb:///lustre/scratch/sboyane/camplaevi/01_blochmannia/02_vcf/${input_array} \
-L helper5.list \
--include-non-variant-sites \
--ploidy 1 \
-O /lustre/scratch/sboyane/camplaevi/01_blochmannia/03_vcf/${input_array}_final.g.vcf

