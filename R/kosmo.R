require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "kosmo",
  birth = "2021-05-01",
  sex = "male",
  tags = c("kosmo", "skyline"),
  filial = " ",
  sire = list(
    name = "Skyline",
    loc = "chams101.md"
  ),
  dam = list(
    name = "Eric Thompson Female",
    loc = "chams101.md"
  )
)
