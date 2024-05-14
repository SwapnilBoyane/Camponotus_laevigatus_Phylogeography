interactive -p quanah

cd /lustre/scratch/sboyane/camponotus/06_related_files

# copy files
cp ../admix20kbp/*simple* .


# load R
module load intel R

R
# To download 'related' 
#install.packages("related", repos="http://R-Forge.R-project.org")



# convert to related package style format

source("vcf_to_related.r")
#keep popmap file in the same directory
vcf_to_related(input = "relatedness.simple.vcf", output = "relatedness_20kbp.related", popmap = "popmap.txt")




