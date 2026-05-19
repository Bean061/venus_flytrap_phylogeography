setwd("/work/users/w/z/wzhou10/venus_flytrap/IBD")
.libPaths(new ="/work/users/w/z/wzhou10/R_lib_new/")

#package.install('vegan')

library(vegan)
#Loading required package: permute
#Loading required package: lattice
#This is vegan 2.6-10

dist1 <- read.csv("genetic_distance_matrix3.csv", row.names = 1, header = TRUE)
dist2 <- read.csv("geographic_distance_matrix_km3.csv", row.names = 1, header = TRUE)
pop1 <- rownames(dist1)
pop2 <- rownames(dist2)
common_pops <- intersect(pop1, pop2)
#length(common_pops)
#[1] 33
#head(common_pops)
#[1] "BIL"  "BRC"  "BSL1" "BSL3" "BSLO" "CI"
dist1_common <- dist1[common_pops, common_pops]
dist2_common <- dist2[common_pops, common_pops]
dim(dist1_common)
#[1] 33 33
#dim(dist2_common)
#[1] 33 33

dist1_matrix <- as.dist(dist1_common)
dist2_matrix <- as.dist(dist2_common)
mantel_result <- mantel(dist1_matrix, dist2_matrix, method = "pearson", permutations = 9999)
print(mantel_result)

#Mantel statistic based on Pearson's product-moment correlation

#Call:
#mantel(xdis = dist1_matrix, ydis = dist2_matrix, method = "pearson",      permutations = 9999)

#Mantel statistic based on Pearson's product-moment correlation
#
#Call:
#mantel(xdis = dist1_matrix, ydis = dist2_matrix, method = "pearson",      permutations = 9999)
#
#Mantel statistic r: 0.5893
#      Significance: 1e-04
#
#Upper quantiles of permutations (null model):
#  90%   95% 97.5%   99%
#0.127 0.162 0.193 0.226
#Permutation: free
#Number of permutations: 9999

pdf("mantel_plot2.pdf", width = 8, height = 6)


## Scatterplot of distances
plot(dist1_matrix, dist2_matrix,
      xlab = "genetic_distance_FST", ylab = "geographic_distance_km",
      main = "Distance Comparison")
abline(lm(as.vector(dist2_matrix) ~ as.vector(dist1_matrix)), col = "red")

dev.off()
