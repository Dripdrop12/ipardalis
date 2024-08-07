require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "ranoka",
  birth = "2022-06-05",
  sex = "male",
  tags = c("ranoka", "manjaka", "lokana", "arlo", "kromatisk", "landy"),
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
