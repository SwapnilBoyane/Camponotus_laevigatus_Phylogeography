#!/bin/sh
#SBATCH --chdir=./
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --mem-per-cpu=64G
#SBATCH --partition=quanah
#SBATCH --time=48:00:00
#SBATCH --job-name=easySFS

cd /lustre/scratch/sboyane/camplaevi/gadma

source activate easySFS


# run easySFS, first in preview mode then for real based on the preview
# projection based on downsampled --proj=10,10,20

~/easySFS/easySFS.py \
  -i combined_10mis_variant.vcf \
  -p popmap_gadma.txt \
  -o easysfs_final_nov_101020 \
  -a --proj=10,10,20 --total-length 184409011
