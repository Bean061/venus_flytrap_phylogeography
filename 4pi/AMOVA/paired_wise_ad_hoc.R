setwd("/YOUR/WORK/PATH/")
.libPaths(new ="/YOUR/R_lib/PATH")

library(ape)
library(adegenet)
library(poppr)

# Load data
phy <- read.dna("/YOUR/IPYRAD/OUTPUT/FILE/50.usnps", format = "sequential")  # or "interleaved"
gen <- DNAbin2genind(phy)

# Load population info
popmap <- read.table("population.txt", header = FALSE)
colnames(popmap) <- c("sample", "group")
gen@pop <- as.factor(popmap$group[match(rownames(gen@tab), popmap$sample)])

# Unique populations
pop_list <- unique(pop(gen))
pairwise_phi <- matrix(NA, nrow = length(pop_list), ncol = length(pop_list),
                       dimnames = list(pop_list, pop_list))

# Pairwise AMOVA loop
for (i in 1:(length(pop_list) - 1)) {
  for (j in (i + 1):length(pop_list)) {
    pops <- pop_list[c(i, j)]
    gen_sub <- gen[pop(gen) %in% pops, ]
    gen_sub@pop <- droplevels(pop(gen_sub))
    
    try({
      amova_res <- poppr.amova(gen_sub, ~pop)
      phi_val <- amova_res$componentsofcovariance["Between populations", "Sigma"] /
                 sum(amova_res$componentsofcovariance[, "Sigma"])
      pairwise_phi[i, j] <- phi_val
      pairwise_phi[j, i] <- phi_val
    }, silent = TRUE)
  }
}

# Display matrix
print(round(pairwise_phi, 4))

