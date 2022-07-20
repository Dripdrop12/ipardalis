require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "ghost",
  birth = "2021-10-17",
  sex = "male",
  tags = c("ghost", "arti", "daisy", "jude", "artemis"),
  filial = "F4-CG13",
  sire = list(
    name = "arti",
    loc = ""
  ),
  dam = list(
    name = "daisy",
    loc = ""
  )
)
