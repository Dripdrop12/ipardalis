require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "paige",
  birth = "2021-04-17",
  sex = "female",
  tags = c("paige", "pj", "sonny", "pyro"),
  filial = "F4-CG13",
  sire = list(
    name = "PJ",
    loc = "moderndaydragons.md"
  ),
  dam = list(
    name = "Sonny's Daughter",
    loc = "tropical.md"
  )
)