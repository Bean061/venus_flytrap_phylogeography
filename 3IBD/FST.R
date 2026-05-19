setwd("/YOUR/WORK/PATH")
.libPaths(new ="/YOUR/R_lib/PATH")

#/PATH/OF/YOUR/50.vcf

library(adegenet)
library(hierfstat)
library(vcfR)

# Load VCF (convert to genind)
snps <- read.vcfR("/YOUR/IPYRAD/OUTPUT/50.vcf")
genind <- vcfR2genind(snps)

# Assign populations (population.csv file only contains one column with population name in each row matching to individuals in vcf file)
data <- read.csv("population.csv", header = TRUE)
pop_labels <- data$replaced_pop_for_Fst

#pop(genind) <- pop_labels
genind$pop <- factor(pop_labels)

# Calculate pairwise FST (Weir & Cockerham)
fst_matrix <- pairwise.WCfst(genind)
write.csv(fst_matrix, "fst_matrix.csv", row.names = TRUE)

# Convert FST to genetic distance matrix
genetic_dist <- fst_matrix / (1 - fst_matrix)

write.csv(genetic_dist, "genetic_distance_matrix.csv", row.names = TRUE)
head(genetic_dist)
