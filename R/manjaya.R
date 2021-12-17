require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "manjaya",
  birth = "2020-12-06",
  sex = "female",
  tags = c("manjalla", "arlo", "pyro", "sparkles"),
  filial = "F1-CG5",
  sire = list(
    name = "Arlo (WC)",
    loc = "coloradochams.md"
  ),
  dam = list(
    name = "Perregrin/Pyro's Daughter",
    loc = "coloradochams.md"
  )
)
