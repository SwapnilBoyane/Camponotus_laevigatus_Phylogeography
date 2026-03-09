# Camponotus_laevigatus_Phylogeography

# C. laevigatus (host)
1. set up directories: 
2. Run "01_align_camplaevi.sh" to align host fastq files.
3. Run "01a_camplaevi_depth.sh" for coverage.
4. Run "02_camplaevi_create_genotyping_scripts.r" to create genotype scripts for the host genomes.
5. Run "02a_genotype_site_per_indivi.sh" to conut total genotyped sites.
6. Run "03_camplaevi_filter.sh" to filter SNPs for downstream analyses.


# Blochmannia pipeline 
1. Run "01a_extract_blochmannia.sh" to extraxct blochmannia reads.
2. Run "01b_align_blochmannia.sh" to align blochmannia reads.
3. Run "01c_blochmannia_depth.sh" for coverage.
4. Run "02_blochmannia_genotyping.sh" to genotype. Note: "--ploidy 1" was mentioned during genotyping.
5. Run "02a_genotype_site_per_indivi.sh" to conut total genotyped sites.
6. Run "03_filter_blochmannia.sh" to filter SNPs for downstream analyses.

**Analyses**

**Population Structure**
1. Run "01_PCA_analysis" to perform Principal component analysis for both host and endosymbiont.
2. Run "02_Admixture.sh" to perform ADMIXTURE analysis.

**Phylogeny**
1. 01_concatenate_vcf_files.sh: Concatenate the vcf files.
2. 02_camp_sp_genome_filtered.fasta.fai: Reference index file
3. 03_phylo_50kbp.r: This creates the tree_100kbp/ directory containing the phylo100kbp_array.sh submission script. Submit "phylo100kbp_array.sh" to array job for running.
4. 04_combine_trees_Camponotus.r: Combine all individual RAxML_bipartitions.tre files into a single file.
5. 05_species_trees.sh: contains script to generate Maximum Clade Credibility tree using DendroPy and a species tree using ASTRAL.

**EEMS**

*Host* 
1. 01_host_vcf2diffs_script.R: Convert vcf filre to .diffs.
2. laevigatus_eems.coord: File with sample coordinates
3. laevigatus_eems.diffs: Genetic distances for eems
4. laevigatus_eems.outer: Outer boundries for EEMS
5. laevigatus_eems.params: Contains parameter for EEMS
6. _run_camplaevi_eems.sh: Slurm array job for EEMS

*Endosymbiont*
1. 01_endosymbiont_vcf2diffs_script.R: Convert vcf filre to .diffs.
2. blochmannia_eems.coord: File with sample coordinates
3. blochmannia_eems.diffs: Genetic distances for eems
4. blochmannia_eems.outer: Outer boundries for EEMS
5. blochmannia_eems.params: Contains parameter for EEMS
6. _run_blochmannia_eems.sh: Slurm array job for EEMS




