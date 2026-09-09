# EBA scRNA-seq training project
#Disease collagen-induced-arthritis
# Lesson 2: Project setup

#R.version.string
packageVersion("Seurat")

library(Seurat)
library(Matrix) #package supports sparse matrices

getwd()

getwd() #Path of working directory 

#Create directories


dir.create("data")
dir.create("data/raw") #/ means subdirectory 
dir.create("data/processed")

dir.create("scripts")
dir.create("figures")
dir.create("results")

list.files()

file.create(".gitignore")

list.files(all.files = TRUE)

writeLines(
  c(
    "data/raw/",
    ".Rhistory",
    ".RData",
    ".Rproj.user/",
    ".DS_Store"
  ),
  ".gitignore"
)

readLines(".gitignore")

list.files("scripts") #Check files existed in folder script

dir.create(
  "data/raw/training_spleen",
  recursive = TRUE,
  showWarnings = FALSE
)

list.files("data/raw")

getwd()


