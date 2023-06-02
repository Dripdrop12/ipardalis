require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "teny",
  birth = "2022-09-10",
  sex = "female",
  tags = c("teny", "tony", "pj"),
  filial = "F5-CG14",
  sire = list(
    name = "Tony",
    loc = ""
  ),
  dam = list(
    name = "Paige",
    loc = ""
  )
)
