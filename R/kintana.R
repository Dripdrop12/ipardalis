require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "kintana",
  birth = "2022-07-31",
  sex = "female",
  tags = c("kintana", "capella", "kromatisk", "jj", "felipe sanchez"),
  filial = "F3-CG14",
  sire = list(
    name = "Capella",
    loc = "chromatic.md"
  ),
  dam = list(
    name = "Kromatisk's daughter",
    loc = "chromatic.md"
  )
)
