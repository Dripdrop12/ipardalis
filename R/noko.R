require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "noko",
  birth = "2021-06-03",
  sex = "female",
  tags = c("noko", "nugget", "loko", "jude", "kromatisk"),
  filial = "F4-CG14",
  sire = list(
    name = "nugget",
    loc = ""
  ),
  dam = list(
    name = "loko",
    loc = ""
  )
)
