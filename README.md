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
   
