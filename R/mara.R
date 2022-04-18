require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "mara",
  birth = "2021-07-13",
  sex = "female",
  tags = c("mara", "sammy", "nova", "legion"),
  filial = "F3",
  sire = list(
    name = "Sammy",
    loc = "chitown.md"
  ),
  dam = list(
    name = "Storm",
    loc = "chitown.md"
  )
)