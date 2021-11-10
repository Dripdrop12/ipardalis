require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "zava",
  birth = "2021-03-21",
  sex = "male",
  tags = c("green giant", "promise keeper", "herb"),
  filial = "F3-CG13",
  sire = list(
    name = "Itso-triombe (Green Giant)",
    loc = "kammerflage.md"
  ),
  dam = list(
    name = "Jiona (June)",
    loc = "kammerflage.md"
  )
)
