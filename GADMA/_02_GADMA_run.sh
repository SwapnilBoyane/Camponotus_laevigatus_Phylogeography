!/bin/sh
#SBATCH --chdir=./
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --mem-per-cpu=64G
#SBATCH --partition=nocona
#SBATCH --time=48:00:00
#SBATCH --job-name=gad_oct

cd /lustre/scratch/sboyane/camplaevi/gadma

#source activate easySFS
source activate gadma_env

# initiaul run

~/anaconda3/envs/gadma_env/bin/gadma -p param_easySFS_3_gadma_years101020.txt

~/anaconda3/envs/gadma_env/bin/gadma --resume gadma_output_mis10_november_101020  -o gadma_output_mis10_november_101020_2

~/anaconda3/envs/gadma_env/bin/gadma --resume gadma_output_mis10_november_101020_2  -o gadma_output_mis10_november_101020_3
