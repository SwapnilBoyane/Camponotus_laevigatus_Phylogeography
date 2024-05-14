# for 50 kbp directory
#make sure in windows only RAxML_bipartitions.tre are present

options(scipen=999)

# list all the files in the trees directory
x_files <- list.files("windows", full.names=T)

# find the chromosome, start, and end for each tree
x_names <- list.files("windows")
x_chrom <- sapply(strsplit(sapply(strsplit(x_names, "RAxML_bipartitions."), "[[", 2), "__"), "[[", 1)
x_start <- sapply(strsplit(x_names, "__"), "[[", 2)
x_end <- sapply(strsplit(sapply(strsplit(x_names, "__"), "[[", 3), ".tre"), "[[", 1)


# write tree info
write.table(cbind(x_chrom, x_start, x_end), file="laevigatus_50kbp_tree_info.txt", sep="\t", quote=F, row.names=F, col.names=F)

# trees into one file
tree_list <- list()
for(a in 1:length(x_files)) {
	tree_list[[a]] <- scan(x_files[a], what="character")
}

tree_list <- unlist(tree_list)
write(tree_list, file="laevigatus.trees", ncolumns=1)














# maximum clade credibility tree (simple summarization) from all gene trees using dendropy:
# gives info about which nodes have support from what proportion of gene trees
sumtrees.py --output=laevigatus.tre --min-clade-freq=0.05 laevigatus.trees



# coalescent tree of all gene trees using ASTRAL III
# automatically calculates local branch support using quartets, described here: https://doi.org/10.1093/molbev/msw079
java -jar /lustre/work/sboyane/Astral/astral.5.7.8.jar -i laevigatus.trees -o laevigatus_astral.tre 2> laevigatus_astral.log


# coalescent tree of all gene trees using ASTRAL III
# automatically calculates local branch support using quartets, described here: https://doi.org/10.1093/molbev/msw079
java -jar /lustre/work/sboyane/Astral/astral.5.7.8.jar -i RAxML_bipartitions.scaffold0001.tree -o blochmannia_astral.tre 2> blochmannia_astral.log

sumtrees.py --output=blochmannia.tre --min-clade-freq=0.05 RAxML_bipartitions.blochmannia.tree
