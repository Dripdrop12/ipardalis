require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "nuhana",
  birth = "2021-01-14",
  sex = "female",
  tags = c("nugget", "bohana", "nuhana"),
  filial = "F1-CG5",
  sire = list(
    name = "nugget",
    loc = ""
  ),
  dam = list(
    name = "bohana",
    loc = ""
  )
)
