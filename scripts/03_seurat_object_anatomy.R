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

#Look at RNA features/genes
head(rownames(spleen)) #genes
head(colnames(spleen)) #Cells(Barcodes)

#Expression matrix vs metadata
dim(LayerData(           #In spleen go to assay RNA, In assay RNA
  spleen,                 #go to layer count and give dimensions
  assay = "RNA",
  layer = "counts"
))

#check metadata dimension
dim(spleen[[]]) #Every row in metadata represents one cell
head(spleen[[]])

identical(                #Checked are these two R objects identical?
  colnames(spleen),
  rownames(spleen[[]])
)

#Add own metadata
spleen$sample <- "Saline3"  #create new metadata called sample assign Saline 3
                             #to every cell
head(spleen[[]])
table(spleen$sample) #counts how many samples belong to each category
