require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "jiolahy",
  birth = "2021-07-14",
  sex = "female",
  tags = c("jiolahy", "the don", "perrigrin", "pyro"),
  filial = "F1-CG5",
  sire = list(
    name = "The Don (WC)",
    loc = "chams101.md"
  ),
  dam = list(
    name = "Perregrin/Pyro's Daughter",
    loc = "chams101.md"
  )
)
