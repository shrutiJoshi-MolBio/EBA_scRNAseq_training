packageVersion("Seurat")

library(Seurat)
library(Matrix) #package supports sparse matrices

#Read matrix(from CellRanger files)

counts <- readMM("data/raw/training_spleen/Saline3_cellranger_outs/Saline3.matrix.mtx")
class(counts)
dim(counts) #dimensions

#Read gene information(rows in matrix)

genes <- read.delim(
  "data/raw/training_spleen/Saline3_cellranger_outs/Saline3.genes.tsv",
  header = FALSE
)

#Inspect genes(object)

head(genes) #shows first six rows
dim(genes) #dimensions

#Read barcodes and inspect barcodes file
barcodes <- read.delim(
  "data/raw/training_spleen/Saline3_cellranger_outs/Saline3.barcodes.tsv",
  header = FALSE
)
head(barcodes)
dim(barcodes)

#Now connect all three files

#before connecting inspect all files once 
class(counts)
dim(counts)

head(genes)
dim(genes)

head(barcodes)
dim(barcodes)

#give the matrix row names
rownames(counts) <- genes$V2

#give the matrix columns their cell barcodes
colnames(counts) <- barcodes$V1

#check matrix file now
dim(counts)
head(rownames(counts))
head(colnames(counts))

#this count is a one labelled object(Joining 3 different files)
#verify mtrix
rownames(counts) [202]
colnames(counts)[1]
counts[202, 1]

#Create first Seurat object

#spleen <- CreateSeuratObject(
 # counts = counts,
  #project = "Saline3"
#)

# got error with duplicate names- check why and debug
anyDuplicated(rownames(counts))
head(rownames(counts)[duplicated(rownames(counts))], 20)
counts <- counts[!duplicated(rownames(counts)), ]#Do not ever do this

#now we have to restore the original matrix again because duplicate rows were removed from the in-memory count object

# get path of matrix file to read
list.files(
  "data/raw",
  recursive = TRUE
)
list.files(
  "data/raw",
  pattern = "matrix.mtx",
  recursive = TRUE,
  full.names = TRUE
)
history()

#now reload all 3 files and run same codes again
library(Matrix)

counts <- readMM(
  "data/raw/training_spleen/Saline3_cellranger_outs/Saline3.matrix.mtx"
)

genes <- read.delim(
  "data/raw/training_spleen/Saline3_cellranger_outs/Saline3.genes.tsv",
  header = FALSE
)

barcodes <- read.delim(
  "data/raw/training_spleen/Saline3_cellranger_outs/Saline3.barcodes.tsv",
  header = FALSE
)

#assign gene names and barcodes
rownames(counts) <- make.unique(genes$V2) #here there is a change we used make.unique to not get duplicate row names and preserve all rows
colnames(counts) <- barcodes$V1

dim(counts)

anyDuplicated(rownames(counts))

#again create Seurat object

spleen <- CreateSeuratObject(
  counts = counts,
  project = "Saline3"
)
#Seurat object spleen is created successfully 
#ask seurat what spleen contains
spleen

#inspect dimensions
dim(spleen)

#Look at metadata 
head(spleen@meta.data)

#metadata contains nCount_RNA and nFeature_RNA which are imp for QC 
# verify Seurat for one real cell(practice)

first_cell <- colnames(counts)[1] #gives barcode
first_cell 

sum(counts[, first_cell]) #sum of columns from counts for first cell
#= nCount from metadata
#compare above value with value in metadata
spleen@meta.data[first_cell, "nCount_RNA"]

#verify nFeature_RNA count 
sum(counts[, first_cell] > 0)

spleen@meta.data[first_cell, "nFeature_RNA"]