# EBA scRNA-seq training project
# Lesson 4: Anatomy of a Seurat object

#Tell R to run a command from script 02_load_data.R 
source("scripts/02_load_data.R")
 

#What kind of R object is spleen?

class(spleen)
class(counts) 

spleen

Assays(spleen)

#look inside RNA assay

spleen[["RNA"]]

#Lets validate if our original matrix really inside there
seurat_counts <- LayerData(
  spleen,
  assay = "RNA",
  layer = "counts"
)

seurat_counts[
  "Rpl7",                         #This is a known value; 
  "AAACCTGAGCAACGGT-1"        #How much Rpl7 is inside this barcpoded cell
]

#Check metadata
head(spleen[[]]).      #head: first 6 values 

#Features, cells, metadata and identities
dim(spleen)
nrow(spleen).     #number of features/cells
ncol(spleen)      #number of cells
