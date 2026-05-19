setwd("/YOUR/WORK/PATH/")
.libPaths(new ="/YOUR/R_lib/PATH/")
# Required Libraries

#2D PCA plot
# Load required libraries
library(ggplot2)

# Read the CSV file generated from vcf file from ipyrad ipa.pca (update file path if needed)
pca_data <- read.csv("pca_analysis_final.csv", header = TRUE)

head(pca_data)
# Ensure Population column is a factor for coloring
pca_data$large_category <- as.factor(pca_data$large_category)

# Create PCA scatter plot (PC1 vs PC2)
ggplot(pca_data, aes(x = X0, y = X1, color = large_category)) +
  geom_point(size = 3, alpha = 0.8) +
  theme_minimal() +
  labs(title = "PCA Plot", x = "PC1", y = "PC2") +
  scale_color_manual(values = rainbow(length(unique(pca_data$large_category)))) +
  theme(legend.position = "right")


#3D PCA plot by plotly
# Install plotly if not installed
if (!requireNamespace("plotly", quietly = TRUE)) install.packages("plotly")

library(plotly)

pca_data2 <- read.csv("pca_analysis_final.csv", header = TRUE)
pca_data2$large_category <- as.factor(pca_data$large_category)

# 3D PCA plot
p<-plot_ly(pca_data2, x = ~X0, y = ~X1, z = ~X2, color = ~large_category, colors = "Set1",
        type = "scatter3d", mode = "markers", marker = list(size = 5)) %>%
  layout(title = "3D PCA Plot", scene = list(xaxis = list(title = "PC1"),
                                             yaxis = list(title = "PC2"),
                                             zaxis = list(title = "PC3")))

htmlwidgets::saveWidget(p, "3D_PCA_plot.html")
