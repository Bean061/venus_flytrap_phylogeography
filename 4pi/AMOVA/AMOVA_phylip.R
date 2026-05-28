setwd("/WORK/PATH/venus_flytrap/pi/AMOVA")
.libPaths(new ="/WORK/PATH/R_lib/")

library(ape)
library(adegenet)
library(poppr)

# Load PHYLIP file
phy <- read.dna("/OUTPUT/FROM/IPYRAD/venus_flytrap/50_outfiles/50.usnps", format = "sequential")  # or "interleaved" if that's the format

# Convert to genind
gen <- DNAbin2genind(phy)

# Add population structure
popmap <- read.table("population.txt", header = FALSE)
colnames(popmap) <- c("sample", "group")
gen@pop <- as.factor(popmap$group[match(rownames(gen@tab), popmap$sample)])

amova_res <- poppr.amova(gen, ~ group)
amova_res

# Significance test
randtest(amova_res, nrepet = 999)

#pop(gen) <- factor(metadata$Population)

# Pairwise AMOVA
pairwise_results <- poppr.amova(gen, ~ group, within = TRUE, pairwise = TRUE)

# Show Phi_ST matrix
pairwise_results$phi.st
