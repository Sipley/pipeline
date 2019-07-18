#!/usr/bin/env Rscript

# set mirror
local({r <- getOption("repos")
       r["CRAN"] <- "http://cran.r-project.org" 
       options(repos=r)
})

# Install required packages
install.packages("tidyverse")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("ggtree")
install.packages("phangorn")

# Load required packages
library(tidyverse)
library(ggtree)
library(phangorn)

# Set working directory
# setwd("/usr/local/pipeline/tmp/")
setwd("~/Documents/MS/pipeline/tmp")

# Load maximum-likelihood tree
tree <- read.tree("RAxML_bipartitionsBranchLabels.WAG.10bp")
tree_midroot <- midpoint(tree, node.labels = "support")

# Load data from SignalP predictions
dd <- read.csv("VAPs.signalp.csv", 
               sep = "\t",
               col.names = c("tipLabel", "signalP"), 
               header = FALSE, 
               stringsAsFactors = TRUE)

# Annotate maximum-likelihood tree with signal peptide predictions
p1 <- ggtree(tree_midroot, layout="circular", aes(color=signalP)) %<+% dd +
  geom_tippoint(aes(color=signalP),alpha=1,size=0.5) +
  theme(legend.position = c(1,0.5))

png("tree_signalp.png", width=622)
p1
dev.off()
