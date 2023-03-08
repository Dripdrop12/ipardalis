require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "mena",
  birth = "2022-07-27",
  sex = "female",
  tags = c("zava", "arlo", "green giant", "pyro"),
  filial = "F2-CG14",
  sire = list(
    name = "zava",
    loc = ""
  ),
  dam = list(
    name = "manjaya",
    loc = ""
  )
)
