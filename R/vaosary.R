require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "vaosary",
  birth = "2022-01-11",
  sex = "female",
  tags = c("vaosary", "papafee", "lokana", "kromatisk"),
  filial = "F4-CG14",
  sire = list(
    name = "Papafee",
    loc = ""
  ),
  dam = list(
    name = "Lokana",
    loc = ""
  )
)
