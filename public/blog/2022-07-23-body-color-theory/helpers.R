# helper for creating color palettes with gene annotations
gene_palette <- function(gene_count = 3, color = "Reds") {
  jpeg(
    filename = paste0(gene_count, color, ".jpeg"),
    width = 1200,
    height = 400)
  
  poss_outcomes <- generate_poss_outcomes(gene_count)
  tot <- max(poss_outcomes$capitals)
  pal <- c("#FFFFFF", brewer.pal(tot, color))
  hist(x = poss_outcomes$capitals, 
       right = FALSE, 
       breaks = 0:(tot+1), 
       col = pal, 
       probability = TRUE,
       main = "Distribution of Color",
       xlab = "Additive Allele Count (Capitals)")
  x <- poss_outcomes$capitals
  sq <- seq(min(x), max(x)+1)
  fun <- dnorm(sq, mean = mean(x), sd = sd(x))
  lines(sq, fun, col = 2, lwd = 2)
  
  dev.off()
}



# Create a data frame with all potential outcomes
generate_poss_outcomes <- function(gene_count = 2, ploidy = 2) {
  allele_list <- list()
  for (i in 1:gene_count) {
    allele_list[[paste0("gene",i)]] <- create_genotype(LETTERS[i], ploidy = ploidy)
  }
  poss_output <- expand.grid(allele_list) %>%
    unite(
      genotype, everything(), sep = "", remove = FALSE
    ) %>%
    mutate(
      capitals = str_count(genotype, "[A-Z]")
    ) %>%
    arrange(capitals)
  
  return(poss_output)
}

create_genotype <- function(let, ploidy = 2){
  if (ploidy == 2) {
    c(
      paste0(str_to_upper(let), str_to_upper(let)),
      paste0(str_to_upper(let), str_to_lower(let)),
      paste0(str_to_lower(let), str_to_upper(let)),
      paste0(str_to_lower(let), str_to_lower(let))
    )
  } else {
    c(
      c(str_to_upper(let), str_to_lower(let))
    )
  }
}
