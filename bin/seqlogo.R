#!/usr/bin/env Rscript

install.packages("ggseqlogo")

library(ggseqlogo)
library(ggplot2)

# Command line options


input_files <- list.files( pattern="\\.txt$", full.names = TRUE)


for (seq_file in input_files) {
  sample_id <- sub("\\.txt$", "", basename(seq_file))
  output_file <- file.path( paste0(sample_id, "_logo.png"))
  
  seqs <- readLines(seq_file)
  seqs <- sapply(strsplit(seqs, "\\s+"), `[`, 1)
  
  seqs <- seqs[!is.na(seqs) & nchar(seqs) ==12 ]
  seqs <- seqs[!grepl("N", seqs)]
  max_length <- max(nchar(seqs))
  
  png(output_file, width=800, height=400)
  
  # Create the sequence logo plot with custom x-axis labels
  p <- ggseqlogo(seqs) + 
    ggtitle(sample_id) +
    scale_x_continuous(
      breaks = 1:max_length,
      labels = 1:max_length  
    ) +
    xlab("Position") +
    theme(axis.text.x = element_text(angle = 0, hjust = 0.5))
  
  
  print(p)
  dev.off()
  
  
}

