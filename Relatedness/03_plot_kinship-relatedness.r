#The code is adapted from https://github.com/jdmanthey/camponotus_relatedness_revised.

############################## Plot Kinship #############################
####                                                                 ####
#########################################################################
#set wording directory
setwd("/Volumes/Swapnil_T7/Camponotus/04_related_vcf_20kbp")

options(scipen=999)
# Load required libraries
library(gmt)
library(RColorBrewer)
library(stringr)
library(ggplot2)
#define input files
laev <- read.table("laevigatus__20kbp__relatedness.txt", header=T)

# Read in data from file.txt"
loc <- read.table("C_laevigatus_localities 2.txt", header = TRUE)
# plot colors
plot_colors <- brewer.pal(12, "Paired") # use 3, 4, 7, 8, 9, 10

x <- laev

# Subset laev comparisons 
laev2 <- subset(x, ind1 %in% loc$Locality & ind2 %in% loc$Locality)

# Calculate geographic distances between laevigatus localities
distance_km <- c()
for (i in 1:nrow(laev2)) {
  # Get coordinates of locality 1
  loc1_lat <- loc$Lat[loc$Locality == laev2$ind1[i]]
  loc1_long <- loc$Long[loc$Locality == laev2$ind1[i]]
  
  # Get coordinates of locality 2
  loc2_lat <- loc$Lat[loc$Locality == laev2$ind2[i]]
  loc2_long <- loc$Long[loc$Locality == laev2$ind2[i]]
  
  if(loc1_lat == loc2_lat & loc1_long == loc2_long) {
    dist_km <- 0
  } else {
    # Calculate distance between the two localities in km
    dist_km <- geodist(loc1_lat, loc1_long, loc2_lat, loc2_long, units = "km")
  }
  
  # Append the distance to the distance_km vector
  distance_km <- c(distance_km, dist_km)
}

#Add the distance_km vector as a new column to the laev2 data
laev2$distance_km <- distance_km

# Plot laev2 vs. distance_km
plot(laev2$KINGrobust ~ laev2$distance_km, pch = 19, cex = 0.8)

# Add a linear regression line to the plot
abline(lm(laev2$KINGrobust ~ laev2$distance_km))

# Calculate and print summary statistics of the linear regression model
summary(lm(calculated_stat ~ distance_km, data = laev2))

#save as pdf 
pdf("R1vsR0_final.pdf", height = 6, width = 5)
#plot R1 vs R0
ggplot(laev2, aes(x = R1, y = R0)) +
  geom_point(data = laev2[laev2$distance_km > 1,  ], col = "#CF0A0A", alpha = 0.6, size = 3.9) +
  geom_point(data = laev2[laev2$distance_km == 0, ], col = "#FFCC29", alpha = 0.8, size = 4) +
  geom_point(data = laev2[laev2$distance_km > 0 & laev2$distance_km < 1, ], col = "#000000", alpha = 0.8, size = 4) +
  
  xlim(0, max(laev2$R1)) +
  ylim(0, max(laev2$R0)) +
  labs(x = "R1", y = "R0") +
  theme_linedraw()
dev.off()

pdf("R1vsKingRobust_final.pdf", height = 6, width = 5)
#plot R1 vs KingRobust
ggplot(laev2, aes(x = R1, y = KINGrobust)) +
  geom_point(data = laev2[laev2$distance_km > 1,  ], col = "#CF0A0A", alpha = 0.6, size = 4) +
  geom_point(data = laev2[laev2$distance_km == 0, ], col = "#FFCC29", alpha = 0.8, size = 4) +
  geom_point(data = laev2[laev2$distance_km > 0 & laev2$distance_km < 1, ], col = "#000000", alpha = 0.8, size = 4) +
  xlim(0, max(laev2$R1)) +
  ylim(0, max(laev2$KINGrobust)) +
  labs(x = "R1", y = "KINGrobust") +
  theme_linedraw()
dev.off()
