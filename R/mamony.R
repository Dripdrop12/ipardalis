require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "mamony",
  birth = "2021-06-20",
  sex = "female",
  tags = c("mamony", "blossom", "maitso", "jude", "amarillo"),
  filial = "F4-CG13",
  sire = list(
    name = "Blossom",
    loc = ""
  ),
  dam = list(
    name = "Maitso",
    loc = ""
  )
)
