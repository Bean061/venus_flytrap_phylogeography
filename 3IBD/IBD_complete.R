setwd("/Users/zhouwenbin/Documents/Obsidian\ Vault/projects/Venus_flytrap/OneDrive_1_11-4-2024/Bean/MS/method_scripts_github/5IBD/")
.libPaths(new ="/work/users/w/z/wzhou10/R_lib_new/")

#package.install('vegan')

library(vegan)
library(tidyverse)
#Loading required package: permute
#Loading required package: lattice
#This is vegan 2.6-10

dist1 <- read.csv("genetic_distance_matrix3_Coast.csv", row.names = 1, header = TRUE)
dist2 <- read.csv("geographic_distance_matrix_km3_Coast.csv", row.names = 1, header = TRUE)
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


#sandhill only result
#Mantel statistic based on Pearson's product-moment correlation 

#Call:
#mantel(xdis = dist1_matrix, ydis = dist2_matrix, method = "pearson",      permutations = 9999) 

#Mantel statistic r: -0.5621 
#      Significance: 0.96667 

#Upper quantiles of permutations (null model):
#  90%   95% 97.5%   99% 
#0.523 0.680 0.772 0.837 
#Permutation: free
#Number of permutations: 119


#CFA RESULT
#Mantel statistic based on Pearson's product-moment correlation 

#Call:
##mantel(xdis = dist1_matrix, ydis = dist2_matrix, method = "pearson",      permutations = 9999) 

#Mantel statistic r: 0.3531 
#      Significance: 0.0689 

#Upper quantiles of permutations (null model):
#  90%   95% 97.5%   99% 
#0.304 0.388 0.463 0.539 
#Permutation: free
#Number of permutations: 9999


#OB mantel results
#Mantel statistic based on Pearson's product-moment correlation 

#Call:
#mantel(xdis = dist1_matrix, ydis = dist2_matrix, method = "pearson",      permutations = 9999) 

#Mantel statistic r: 0.2805 
#      Significance: 0.0931 

#Upper quantiles of permutations (null model):
#  90%   95% 97.5%   99% 
#0.259 0.448 0.509 0.561 
#Permutation: free
#Number of permutations: 9999

#Coast mantel results
#Mantel statistic based on Pearson's product-moment correlation 

#Call:
#mantel(xdis = dist1_matrix, ydis = dist2_matrix, method = "pearson",      permutations = 9999) 

#Mantel statistic r: 0.504 
#      Significance: 1e-04 

#Upper quantiles of permutations (null model):
#  90%   95% 97.5%   99% 
#0.125 0.169 0.206 0.240 
#Permutation: free
#Number of permutations: 9999

pdf("mantel_plot2.pdf", width = 8, height = 6)


## Scatterplot of distances
plot(dist1_matrix, dist2_matrix,
     xlab = "genetic_distance_FST", ylab = "geographic_distance_km",
     main = "Distance Comparison")
abline(lm(as.vector(dist2_matrix) ~ as.vector(dist1_matrix)), col = "red")

dev.off()



# Get lower-triangle pairwise distances as vectors
gen_vec  <- as.vector(dist1_matrix)
geo_vec  <- as.vector(dist2_matrix)

# Get the population pairs for each distance
pairs <- as.data.frame(as.matrix(dist1_common)) %>%
  rownames_to_column("Pop1") %>%
  pivot_longer(-Pop1, names_to = "Pop2", values_to = "gen_dist") %>%
  filter(Pop1 < Pop2)         # keep only one triangle

# Add geographic distance
pairs$geo_dist <- as.vector(dist2_matrix)

# (Optional) assign each pair to a population category
# For example: color by the first population's group
# Suppose you have a lookup table of population groups:
pop_groups <- read.csv("population_groups.csv")   # columns: Pop, Group
pairs <- pairs %>%
  left_join(pop_groups, by = c("Pop1" = "Pop")) %>%
  rename(Group1 = Group) %>%
  left_join(pop_groups, by = c("Pop2" = "Pop")) %>%
  rename(Group2 = Group)

# Decide how you want to color:
#  - same group? different groups?
pairs <- pairs %>%
  mutate(color_group = ifelse(Group1 == Group2, Group1, "Between"))

pairs

write.csv(pairs,
          file = "pairs_matrix.csv",
          row.names = FALSE)

pairs <- read.csv("pairs_matrix.csv", header = TRUE)
pairs$color

install.packages("ggpmisc")
library(ggpmisc)

## Scatterplot of distances
plot(pairs$gen_dist, pairs$geo_dist,
     color = pairs$color,
     xlab = "genetic_distance_FST", ylab = "geographic_distance_km",
     main = "Distance Comparison")

abline(lm(as.vector(dist2_matrix) ~ as.vector(dist1_matrix)), col = "red")


ggplot(pairs, aes(y = gen_dist, x = geo_dist, color = color)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  scale_color_identity(name = "Population Group",
                       guide = "legend") + 
  stat_poly_eq(formula = y ~ x,
               aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")),
               parse = TRUE, color = "black") +
  labs(x = "Geographic distance (km)",
       y = "Genetic distance (FST)",
       color = "Population Group") +
  theme_minimal()

pairs_green <- pairs[pairs$color == "green", ]
pairs_orange <- pairs[pairs$color == "orange", ]
pairs_blue <- pairs[pairs$color == "blue", ]

pairs_total <- pairs[
  pairs$color == "green" |
    pairs$color == "orange" |
    pairs$color == "blue", ]


ggplot(pairs_green, aes(y = gen_dist, x = geo_dist, color = color)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  scale_color_identity(name = "Population Group",
                       guide = "legend") + 
  stat_poly_eq(formula = y ~ x,
               aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")),
               parse = TRUE, color = "black") +
  labs(x = "Geographic distance (km)",
       y = "Genetic distance (FST)",
       color = "Population Group") +
  theme_minimal()

ggplot(pairs_blue, aes(y = gen_dist, x = geo_dist, color = color)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  scale_color_identity(name = "Population Group",
                       guide = "legend") + 
  stat_poly_eq(formula = y ~ x,
               aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")),
               parse = TRUE, color = "black") +
  labs(x = "Geographic distance (km)",
       y = "Genetic distance (FST)",
       color = "Population Group") +
  theme_minimal()

ggplot(pairs_orange, aes(y = gen_dist, x = geo_dist, color = color)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  scale_color_identity(name = "Population Group",
                       guide = "legend") + 
  stat_poly_eq(formula = y ~ x,
               aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")),
               parse = TRUE, color = "black") +
  labs(x = "Geographic distance (km)",
       y = "Genetic distance (FST)",
       color = "Population Group") +
  theme_minimal()  

ggplot(pairs_total, aes(y = gen_dist, x = geo_dist, color = color)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  scale_color_identity(name = "Population Group",
                       guide = "legend") + 
  stat_poly_eq(formula = y ~ x,
               aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")),
               parse = TRUE, color = "black") +
  labs(x = "Geographic distance (km)",
       y = "Genetic distance (FST)",
       color = "Population Group") +
  theme_minimal()  


library(vegan)
library(tidyr)

pops <- unique(c(pairs_green$Pop1, pairs_green$Pop2))

pops
head(pairs_green)


gen_mat <- pivot_wider(pairs_green, names_from = Pop2, values_from = gen_dist) %>%
  column_to_rownames("Pop1") %>% as.matrix()
geo_mat <- pivot_wider(pairs_green, names_from = Pop2, values_from = geo_dist) %>%
  column_to_rownames("Pop1") %>% as.matrix()

# Make them symmetric (Mantel requires this)
gen_mat <- (gen_mat + t(gen_mat)) / 2
geo_mat <- (geo_mat + t(geo_mat)) / 2

# Convert to dist objects
gen_dist <- as.dist(gen_mat)
geo_dist <- as.dist(geo_mat)

# Run Mantel test
mantel_result <- mantel(gen_dist, geo_dist, method = "pearson", permutations = 9999)
mantel_result
  