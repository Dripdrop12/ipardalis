require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "Squash",
  birth = "2022-01-14",
  sex = "female",
  tags = c("squash", "mcnulty", "artemis"),
  filial = "F4-CG13",
  sire = list(
    name = "mcnulty",
    loc = "brianstewart.md"
  ),
  dam = list(
    name = "artemis's daughter",
    loc = "brianstewart.md"
  )
)
