require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "tarehy",
  birth = "2022-05-31",
  sex = "female",
  tags = c("tarehy", "manjaka", "arlo", "kromatisk", "landy"),
  filial = "F2-CG14",
  sire = list(
    name = "manjaka",
    loc = ""
  ),
  dam = list(
    name = "lokana",
    loc = ""
  )
)
