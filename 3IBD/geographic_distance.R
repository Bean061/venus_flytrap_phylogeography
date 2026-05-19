setwd("/YOUR/WORK/PATH")
.libPaths(new ="/YOUR/R_lib/PATH")

# Load required packages
library(geosphere)  # For distGeo()
library(tidyverse)  # For data cleaning (optional)

# Your data (replace with your actual data)
coords <- data.frame(
  Pop = c("AGL", "BIL", "BL", "BRC", "BSL1", "BSL3", "BSLO", "CI", "CIR", "CRHS", 
          "CRPR", "CT1", "CT2", "DN", "EPHS", "FS", "GSN", "HIB", "JGSS", "LOB", 
          "LW", "MC", "MD", "MFB", "NM", "PG", "PT", "RL", "S100", "S110", 
          "S8CR", "S90", "SOC", "SPA", "SPC", "T1L", "T2S", "VFTG", "VL1", "VL2"),
  Latitude = c(34.703496, 34.087332, 34.703682, 34.727655, 34.072458, 34.003463, 
               34.015464, 35.091545, 35.098569, 34.527992, 34.728525, 34.612670, 
               34.601390, 35.106866, 34.450686, 34.521730, 34.101560, 34.767784, 
               34.091162, 33.791336, 34.271795, 34.451063, 35.126222, 35.111862, 
               34.745223, 34.741120, 34.308326, 34.785376, 34.020872, 34.109596, 
               33.992132, 33.995710, 34.845081, 34.013764, 34.012057, 34.435285, 
               34.442101, 35.150321, 34.642838, 34.654923),
  Longitude = c(-77.698508, -78.302558, -78.464123, -78.298520, -78.035879, 
                -78.093708, -78.072690, -79.144331, -79.175795, -77.726409, 
                -76.979372, -77.300210, -77.306897, -79.207855, -77.669864, 
                -77.506820, -78.301689, -76.873296, -78.293458, -78.822573, 
                -78.464943, -77.758096, -79.287452, -79.100510, -76.932930, 
                -76.988303, -77.809055, -77.608367, -78.496609, -78.143366, 
                -78.195123, -78.441539, -77.071622, -77.987192, -78.014283, 
                -77.718728, -77.708696, -79.212597, -77.470564, -77.425081)
)

# Remove rows with missing coordinates (e.g., "NA")
coords <- coords[complete.cases(coords), ]

# Compute pairwise distance matrix (in kilometers)
geo_dist <- distm(
  coords[, c("Longitude", "Latitude")], 
  fun = distGeo  # Great-circle distance (WGS84 ellipsoid)
) / 1000  # Convert meters to kilometers

# Set row/column names to population IDs
rownames(geo_dist) <- coords$Pop
colnames(geo_dist) <- coords$Pop

write.csv(geo_dist, "geographic_distance_matrix_km.csv", row.names = TRUE)
