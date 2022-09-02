require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "Papamavo",
  birth = "2022-03-01",
  sex = "male",
  tags = c("bumble bee", "papafee", "lokana", "kromatisk"),
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
