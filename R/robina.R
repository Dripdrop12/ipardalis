require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "robina",
  birth = "2022-03-07",
  sex = "female",
  tags = c("robina", "clapton", "dynamiteTNT"),
  filial = "F3-CG14",
  sire = list(
    name = "Clapton",
    loc = "ramblin.md"
  ),
  dam = list(
    name = "Layla",
    loc = "ramblin.md"
  )
)